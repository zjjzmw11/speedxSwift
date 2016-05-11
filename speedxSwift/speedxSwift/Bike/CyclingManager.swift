//
//  CyclingManager.swift
//  speedxSwift
//
//  Created by speedx on 16/4/22.
//  Copyright © 2016年 speedx. All rights reserved.
//

import UIKit
import MapKit
import Realm

class CyclingManager: NSObject,CLLocationManagerDelegate,MKMapViewDelegate{
    /// 默认5秒打一个点
    let kSpaceTime = UInt(5)
    /// 当前坐标点
    var currentCLLocation : CLLocation?
    /// 定位管理
    var locationManager : CLLocationManager!
    /// 点数组
//    var points : NSMutableArray?
    ///--------------------------速度、里程、时间、定时器------------------------
    /// 速度
    var speed : CLLocationSpeed?
    /// 里程
    var distance : CLLocationDistance?
    /// 时间
    var time : UInt?
    /// 定时器
    var myTimer : NSTimer?
    
    /// 最后一次定位的时间
    var lastLocationTime : NSDate?
    
    /// 骑行记录的model +++++++++++++++++++++++++++++++++++++
    var currentActivity = ActivityModel.getCurrentActivity()
    
    // ----------------------------------------------------
    /// ------自己代理属性
    var cycUIDelegate : CyclingManagerProtocol?
    var cycDelegate : CyclingManagerProtocol?
    /// 是否在后台 true 是在后台   false : 在前台
    var isBackgroundFlag : Bool?
    /// 是否启动骑行 0：未开始  1：启动 2：自动暂停 3：手动暂停（暂时不做）4:继续骑行 5：结束骑行 6：闪退了
    var cyclingType : Int?
    /// 骑行管理单例
    static let cyclingManager:CyclingManager = CyclingManager()
    class func getCyclingManager() -> CyclingManager {
       
        return cyclingManager
    }
    
    required override init() {
        super.init()
        self.locationManager = CLLocationManager()
        self.cyclingType = 0    // 未开始
        self.speed = 0.00
        self.distance = 0.00
        self.time = 0
        // 初始化定位管理器
        self.locationManager.delegate = self
        // 请求定位权限
        if self.locationManager.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization)) {
            self.locationManager.requestAlwaysAuthorization()
        }
        if #available(iOS 9.0, *) {
            self.locationManager.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
        }
        self.locationManager.pausesLocationUpdatesAutomatically = false
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers

        /// 超过 5 米 后，才 执行 定位更新的代码----可以省点
        self.locationManager.distanceFilter = 5
        self.locationManager.startUpdatingLocation() //开始定位---刚启动应用需要定位当前位置。
//        self.locationManager.startUpdatingHeading() // 获取方向的时候用的，暂时不需要
        // 初始化点数组
//        self.points = NSMutableArray()
        // 初始化自己的代理
        
    }
    
    
    // CLLocationManager定位代理方法
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("定位更新了\(locations.last!.speed)--\(locations.last!.coordinate)")
        lastLocationTime = NSDate()
        
//        print("speed====\(speed)----\(CLLocationCoordinate2DIsValid(locations.last!.coordinate))")
        if locations.last != nil {
            self.speed = locations.last!.speed
            if self.speed <= 0 {
                self.speed = 0.00
            }
            // 速度是负数 证明不可用 ??? 也不能用速度判定是否有用。。。
//            if locations.last!.speed > 1.0 {// 当前点才有意义 定位成功当前位置，才有可能stop定位
              if CLLocationCoordinate2DIsValid(locations.last!.coordinate) {// 当前点才有意义 定位成功当前位置，才有可能stop定位

                /// 地球 转成 火星
                let coor = CLLocationCoordinate2D.init(latitude: CoordsTransform.transformGpsToMarsCoords(locations.last!.coordinate.longitude, wgLat: locations.last!.coordinate.latitude).mgLat, longitude: CoordsTransform.transformGpsToMarsCoords(locations.last!.coordinate.longitude, wgLat: locations.last!.coordinate.latitude).mgLon);
                if self.cyclingType == 1 || self.cyclingType == 4 {
                    // -------------- 速度、里程、时间
                    self.speed = locations.last!.speed
                    if self.speed < 0 {
                        self.speed = 0.00
                    }
                    let newLocation = CLLocation.init(latitude: coor.latitude, longitude: coor.longitude)
                    let meters = newLocation.distanceFromLocation(currentCLLocation!)
                    self.distance = self.distance! + meters
                }
                // 首页UI更新代理
                if self.cycUIDelegate != nil {
                    self.cycUIDelegate!.didUpdateUIAction()
                }

                currentCLLocation = CLLocation.init(latitude: coor.latitude, longitude: coor.longitude)
//                self.points?.addObject(currentCLLocation!)
                
                if self.cyclingType == 1 || self.cyclingType == 4 {// 启动、或者继续的时候执行
                    // 地图更新代理
                    if self.cycDelegate != nil {
                        self.cycDelegate!.didUpdateAction(currentCLLocation!,pointArray: self.currentActivity.sampleArray!)
                    }
                }else{//没有在骑行
                    self.locationManager.stopUpdatingLocation()
                }
            }
        }
    }
    // 每秒执行一次
     func myTimerAction() {
        let nowDate = NSDate()
        if lastLocationTime == nil {
            lastLocationTime = NSDate()
        }
        
       let timeDiff = nowDate.timeIntervalSinceDate(lastLocationTime!)
        if self.speed <= 1 || timeDiff > 2{ /// 速度太小不记录 或者 2秒没有定位了。？？？？ 什么时候 增加秒数、什么时候return 需要再想想。
            // todo
//            return
        }
        self.time = self.time! + 1
        /// 每秒一次更新。 但是数据库是5秒一次。
        self.updateActivityAction()

        if self.time!%kSpaceTime == 0 {///每隔5秒存储一个点
            /// 存储数据库
        }
    }
    
    /// 初始化当前骑行记录的数据
    func initActivityAction() {
        self.currentActivity.activityId = String(format: "IOS_%ld",arc4random())
        self.currentActivity.userId = "1" // 暂时这样
        self.currentActivity.title = "测试骑行"
        self.currentActivity.isSyn = false
        self.currentActivity.isFinished = false
        self.currentActivity.isFake = false
        self.currentActivity.startTime = NSDate()
        self.currentActivity.endTime = NSDate()
        self.currentActivity.avgSpeed = 0
        self.currentActivity.maxSpeed = 0
        self.currentActivity.totalDistance = 0
    }
    /// 更新当前骑行记录的数据
    func updateActivityAction() {
//        if self.speed <= 1 { /// 速度太小不记录
        if !CLLocationCoordinate2DIsValid(self.currentCLLocation!.coordinate) {// 当前点才有意义 定位成功当前位置，才有可能stop定位
            return
        }

        self.currentActivity.isSyn = false
        self.currentActivity.isFinished = false
        self.currentActivity.isFake = false
        self.currentActivity.endTime = NSDate()
        if self.currentActivity.maxSpeed < self.speed {
            self.currentActivity.maxSpeed = self.speed
        }
        self.currentActivity.totalDistance = self.distance
        /// 点model
        let currentSample = SampleModel()
        currentSample.sampleId = self.time
        currentSample.currentCLLocation = self.currentCLLocation
        currentSample.lat = self.currentCLLocation?.coordinate.latitude
        currentSample.log = self.currentCLLocation?.coordinate.longitude
        currentSample.speed = self.speed
        currentSample.distance = self.distance
        currentSample.time = self.time
        /// 添加点model
        self.currentActivity.sampleArray?.addObject(currentSample)
        
    }
    
}


/// 骑行代理
protocol CyclingManagerProtocol {
    /// 代理方法 -- 更新位置的方法
    func didUpdateAction(loca : CLLocation, pointArray: NSMutableArray)
    /// 首页的速度、距离、时间等信息
    func didUpdateUIAction()
        
}


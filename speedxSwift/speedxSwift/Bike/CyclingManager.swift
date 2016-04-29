//
//  CyclingManager.swift
//  speedxSwift
//
//  Created by speedx on 16/4/22.
//  Copyright © 2016年 speedx. All rights reserved.
//

import UIKit
import MapKit

class CyclingManager: NSObject,CLLocationManagerDelegate,MKMapViewDelegate{
    
    /// 当前坐标点
    var currentCLLocation : CLLocation?
    /// 定位管理
    var locationManager : CLLocationManager!
    /// 点数组
    var points : NSMutableArray?
    ///--------------------------速度、里程、时间、定时器------------------------
    /// 速度
    var speed : CLLocationSpeed?
    /// 里程
    var distance : CLLocationDistance?
    /// 时间
    var time : UInt?
    /// 定时器
    var myTimer : NSTimer?
    
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
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation() //开始定位---刚启动应用需要定位当前位置。
//        self.locationManager.startUpdatingHeading() // 获取方向的时候用的，暂时不需要
        // 初始化点数组
        self.points = NSMutableArray()
        // 初始化自己的代理
    }
    
    
    // CLLocationManager定位代理方法
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("定位更新了")
        if locations.last != nil {
            // 速度是负数 证明不可用
            if locations.last!.speed > 1.0 {// 当前点才有意义 定位成功当前位置，才有可能stop定位
                /// 地球 转成 火星
                let coor = CLLocationCoordinate2D.init(latitude: CoordsTransform.transformGpsToMarsCoords(locations.last!.coordinate.longitude, wgLat: locations.last!.coordinate.latitude).mgLat, longitude: CoordsTransform.transformGpsToMarsCoords(locations.last!.coordinate.longitude, wgLat: locations.last!.coordinate.latitude).mgLon);
                if self.cyclingType == 1 || self.cyclingType == 4 {
                    // -------------- 速度、里程、时间
                    self.speed = locations.last!.speed
                    let newLocation = CLLocation.init(latitude: coor.latitude, longitude: coor.longitude)
                    let meters = newLocation.distanceFromLocation(currentCLLocation!)
                    self.distance = self.distance! + meters
                }
                // 首页UI更新代理
                if self.cycUIDelegate != nil {
                    self.cycUIDelegate!.didUpdateUIAction()
                }

                currentCLLocation = CLLocation.init(latitude: coor.latitude, longitude: coor.longitude)
                self.points?.addObject(currentCLLocation!)
                
                if self.cyclingType == 1 || self.cyclingType == 4 {// 启动、或者继续的时候执行
                    // 地图更新代理
                    if self.cycDelegate != nil {
                        self.cycDelegate!.didUpdateAction(currentCLLocation!,pointArray: self.points!)
                    }
                }else{//没有在骑行
                    self.locationManager.stopUpdatingLocation()
                }
            }
        }
    }
     func myTimerAction() {
        self.time = self.time! + 1
    }
    
}


/// 骑行代理
protocol CyclingManagerProtocol {
    /// 代理方法 -- 更新位置的方法
    func didUpdateAction(loca : CLLocation, pointArray: NSMutableArray)
    /// 首页的速度、距离、时间等信息
    func didUpdateUIAction()
        
}


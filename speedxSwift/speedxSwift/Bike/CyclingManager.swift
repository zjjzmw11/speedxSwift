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
    /// ------自己代理属性
    var cycDelegate : CyclingManagerProtocol?
    /// 是否在后台 true 是在后台   false : 在前台
    var isBackgroundFlag : Bool?
    
    
    
    /// 骑行管理单例
    static let cyclingManager:CyclingManager = CyclingManager()
    class func getCyclingManager() -> CyclingManager {
       
        return cyclingManager
    }
    
    required override init() {
        super.init()
        self.locationManager = CLLocationManager()
        // 初始化定位管理器
        self.locationManager.delegate = self
        // 请求定位权限
        if self.locationManager.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization)) {
            self.locationManager.requestAlwaysAuthorization()
        }
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation() //开始定位
        // 初始化点数组
        self.points = NSMutableArray()
        // 初始化自己的代理
    }
    
    
    // CLLocationManager定位代理方法
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("定位更新了")
        if locations.last != nil {
            /// 地球 转成 火星
            let coor = CLLocationCoordinate2D.init(latitude: CoordsTransform.transformGpsToMarsCoords(locations.last!.coordinate.longitude, wgLat: locations.last!.coordinate.latitude).mgLat, longitude: CoordsTransform.transformGpsToMarsCoords(locations.last!.coordinate.longitude, wgLat: locations.last!.coordinate.latitude).mgLon);
            currentCLLocation = CLLocation.init(latitude: coor.latitude, longitude: coor.longitude)
            
            // 地图更新代理
            if self.cycDelegate != nil {
                self.cycDelegate!.didUpdateAction(currentCLLocation!)
            }
        }
    }

}

/// 骑行代理
protocol CyclingManagerProtocol {
    /// 代理方法 -- 更新位置的方法
    func didUpdateAction(loca : CLLocation)
        
}


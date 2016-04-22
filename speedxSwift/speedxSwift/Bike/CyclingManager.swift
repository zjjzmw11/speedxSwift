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
        
    }
    
    
    // CLLocationManager定位代理方法
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("定位更新了")
        if locations.last != nil {
            currentCLLocation = locations.last!
            // 设置地图中心
            //            self.mapView.setCenterCoordinateLevel(currentCLLocation!.coordinate, zoomLevel: 15, animated: true)
            print("lat= \(currentCLLocation!.coordinate.latitude) log = \(currentCLLocation!.coordinate.longitude)")
        }
    }
    
    
    
    
}

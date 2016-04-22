//
//  CyclingManager.swift
//  speedxSwift
//
//  Created by speedx on 16/4/22.
//  Copyright © 2016年 speedx. All rights reserved.
//

import UIKit
import MapKit

class CyclingManager: NSObject {

    /// 当前坐标点
    var currentCLLocation : CLLocation?
    
    /// 骑行管理单例
    static let cyclingManager:CyclingManager = CyclingManager()
    class func getCyclingManager() -> CyclingManager {
        return cyclingManager
    }
    
    
    
}

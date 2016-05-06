//
//  Sample.swift
//  speedxSwift
//
//  Created by speedx on 16/5/6.
//  Copyright © 2016年 speedx. All rights reserved.
//

import UIKit
import CoreLocation

/// 骑行记录的点的model
class SampleModel: NSObject {
    /// 点的id --------------------
    var sampleId : UInt?
    /// 当前坐标点
    var currentCLLocation : CLLocation?
    /// 经度 - 火星的
    var lat : CLLocationDegrees?
    /// 维度 - 火星的
    var log : CLLocationDegrees?
    
    /// 速度 -------------------------------
    var speed : CLLocationSpeed?
    /// 里程 - 距离第一个点的里程
    var distance : CLLocationDistance?
    /// 时间 - 距离第一个点的时间 从 1 开始 单位是 s
    var time : UInt?
    
    
    
}

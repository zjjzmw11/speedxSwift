//
//  ActivityModel.swift
//  speedxSwift
//
//  Created by speedx on 16/5/6.
//  Copyright © 2016年 speedx. All rights reserved.
//

import UIKit
import CoreLocation

/// 骑行记录的model
class ActivityModel: NSObject {
    /// 骑行记录的id  --------------
    var activityId : NSString?
    /// 用户id
    var userId : NSString?
    /// 骑行的标题
    var title : NSString?
    /// 点的数组
    var sampleArray : NSMutableArray?
    /// 是否同步到网上
    var isSyn : Bool?
    /// 是否骑行完成
    var isFinished : Bool?
    
    /// 骑行开始时间 -------------------------
    var startTime : NSDate?
    /// 结束时间
    var endTime : NSDate?
    /// 总里程
    var totalDistance : CLLocationDegrees?
    /// 平均速度
    var avgSpeed : CLLocationDegrees?
    /// 最高速度
    var maxSpeed : CLLocationDegrees?
    /// 是否作弊
    var isFake : Bool?
    
    
    /// 骑行记录的单例
    static let currentActivity:ActivityModel = ActivityModel()
    class func getCurrentActivity() -> ActivityModel {
        
        return currentActivity
    }
    
    required override init() {
        super.init()
        /// 点数组初始化
        self.sampleArray = NSMutableArray()
        ///
        
    }

    
    
}

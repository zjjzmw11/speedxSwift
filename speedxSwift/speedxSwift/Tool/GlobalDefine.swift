//
//  GlobalDefine.swift
//  swiftDemo1
//
//  Created by xiaoming on 16/3/7.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import Foundation
import UIKit

/// 是否是iOS9之后的系统
let kIsIOS9Later  =   (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 9.0
/// 是否是iPhone4
let kIsIphone4s   =   (UIScreen.mainScreen().bounds.size.width == 320)
/// 导航栏高度 64
let kNavBarHeight: CGFloat = 64.0
/// tabbar的高度 49
let kTabBarHeight: CGFloat = 49.0
/// 屏幕宽度
let kScreenWidth           = CGRectGetWidth(UIScreen.mainScreen().bounds)
/// 屏幕高度
let kScreenHeight          = CGRectGetHeight(UIScreen.mainScreen().bounds)

let kCalendar              = NSCalendar.currentCalendar()
let kDateFormatter         = NSDateFormatter()


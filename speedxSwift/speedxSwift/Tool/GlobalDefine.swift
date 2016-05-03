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
/// 自定义字体
let kMyFontName            = "BebasNeue"

// -------------------------------颜色定义-----------------------------------------
/// 页面默认背景色、tablView的背景色
let kSpeedX_Color_View_Color_Bg     =   UIColor.hexStringToColor("0X1F1F1F")
/// 导航栏、tabbar
let kSpeedX_Color_Navigation_Bg     =   UIColor.hexStringToColor("0X111111")

/// 页面中TableView的分割线颜色
let kSpeedX_Color_Table_Seperator_Line      =   UIColor.hexStringToColor("0X292929")

/// TableView的cell默认颜色值、
let kSpeedX_Color_Table_Cell_Default_Bg     =   UIColor.hexStringToColor("0X111111")

/// 黑色字体颜色
let kSpeedX_Color_Black_Font    =       UIColor.hexStringToColor("0X111111")
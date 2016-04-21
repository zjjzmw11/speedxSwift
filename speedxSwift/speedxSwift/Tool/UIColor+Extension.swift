//
//  UIColor+Extension.swift
//  PinGo
//
//  Created by GaoWanli on 16/1/16.
//  Copyright © 2016年 GWL. All rights reserved.
//

import UIKit

extension UIColor {
    /**
    创建颜色
    
    - parameter R: 红
    - parameter G: 绿
    - parameter B: 蓝
    - parameter A: 透明度
    */
    class func colorWithRGBA(R: Float, G: Float, B: Float, A: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(R / 255.0), green: CGFloat(G / 255.0), blue: CGFloat(B / 255.0), alpha: CGFloat(A))
    }
}

//class func colorFromHexString(hexString:String) -> UIColor {
//    var rgbValue:CUnsignedInt = 0;
////    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
//    var resultHexString : String?
//    resultHexString = hexString.stringByReplacingOccurrencesOfString("#", withString: "");
//    
//
////    NSScanner *scanner = [NSScanner scannerWithString:hexString];
//    var scanner : NSScanner = NSScanner.localizedScannerWithString(resultHexString!)
////    [scanner scanHexInt:&rgbValue];
//    scanner.scanHexInt(&rgbValue)
//    
////    return [UIColor] colorWithR:((rgbValue & 0xFF0000) >> 16) G:((rgbValue & 0xFF00) >> 8) B:(rgbValue & 0xFF) A:1.0];
//    
//    return UIColor.colorWithRGBA(((rgbValue & 0xFF0000) >> 16.0), G: ((rgbValue & 0xFF00) >> 8.0), B: (rgbValue & 0xFF), A: 1.0)
//}


// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
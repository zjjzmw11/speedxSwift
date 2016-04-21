//
//  Tool.swift
//  swiftDemo1
//
//  Created by xiaoming on 16/3/7.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import Foundation
import UIKit

/**
   封装的UILabel 初始化
 
 - parameter frame:      大小位置
 - parameter textString: 文字
 - parameter font:       字体
 - parameter textColor:  字体颜色
 
 - returns: UILabel
 */
func initALabel(frame:CGRect,textString:String,font:UIFont,textColor:UIColor) -> UILabel {
    let aLabel = UILabel()
    aLabel.frame = frame
    aLabel.backgroundColor = UIColor.clearColor()
    aLabel.text = textString
    aLabel.font = font
    aLabel.textColor = textColor
    aLabel.sizeToFit()
    
    return aLabel
}

/**
 封装的UIButton 初始化
 
 - parameter frame:       位置大小
 - parameter titleString: 按钮标题
 - parameter font:        字体
 - parameter textColor:   标题颜色
 - parameter bgImage:     按钮背景图片
 
 - returns: UIButton 
 */
func initAButton(frame:CGRect ,titleString:String, font:UIFont, textColor:UIColor, bgImage:UIImage) -> UIButton {
    let aButton = UIButton()
    aButton.frame = frame
    aButton.backgroundColor = UIColor.clearColor()
    aButton .setTitle(titleString, forState: UIControlState.Normal)
    aButton .setTitleColor(textColor, forState: UIControlState.Normal)
    aButton.titleLabel?.font = font
    aButton .setBackgroundImage(bgImage, forState: UIControlState.Normal)
    
    return aButton
}
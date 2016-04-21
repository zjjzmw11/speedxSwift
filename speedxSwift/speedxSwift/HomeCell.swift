//
//  HomeCell.swift
//  swiftDemo1
//
//  Created by xiaoming on 16/3/8.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit

typealias funcBlock = (NSIndexPath,UIButton) -> ()

class HomeCell: UITableViewCell {

    var testLabel:UILabel!
    var testButton:UIButton!
    
    var indexP:NSIndexPath!
    /// 按钮点击的block回调
    var buttonClickBlock : funcBlock!
    
    // xib 初始化
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.backgroundColor = UIColor.grayColor()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Class 初始化---------------------------------------------------------------
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        
        testLabel = initALabel(CGRectMake(10, 10, 100, 20), textString: "测试文字", font: UIFont.systemFontOfSize(19), textColor: UIColor.redColor())
        self.contentView.addSubview(testLabel)
        
        testButton = initAButton(CGRectMake(kScreenWidth - 100, 5, 60, 30), titleString: "按钮", font: UIFont.systemFontOfSize(18), textColor: UIColor.redColor(), bgImage: UIImage())
        self.contentView.addSubview(testButton)
        testButton.addTarget(self, action: Selector("buttonAction:"), forControlEvents: .TouchUpInside)
        
    }
    
    func buttonAction(button:UIButton) {
        if (self.buttonClickBlock != nil) {
            self.buttonClickBlock(indexP,testButton)
        }
    }
    
}

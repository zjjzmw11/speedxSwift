//
//  SimpleViewController.swift
//  swiftDemo1
//
//  Created by xiaoming on 16/3/7.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit

class SimpleViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        没有从新赋值的变量都应该用let 否则有警告
        // 简单变量
        let name = "xiaoming"
        var age = 26
        let height = 180.0
        let des = "iOS工程师"
        let isMan = true   // true false 不是OC 里面的 YES NO 了
        var isManString = "女"
        if isMan {
            isManString = "男"
        }
        var sexString:String = isMan ? "男":"女"
//        sexString ?? "不知道"// 如果为空就为后面的值
        age += 1
        print(name + String(age) + String(height) + des + String(isMan))
        // 数组
        let arr = ["apple","banana"]
        print(arr)
        print(arr[0])

        // 用UILabel 把上面的文字展示出来
        let aLabel = UILabel()
        aLabel.frame = CGRectMake(20, 100, kScreenWidth - 40, 0)
        aLabel.backgroundColor = UIColor.clearColor()
        aLabel.font = UIFont.systemFontOfSize(20)
        aLabel.textColor = UIColor.blackColor()
        aLabel.text = "姓名：" + name + "年龄：" + String(age) + "身高：" + String(height) + "\n职位：" + des + "性别：" + isManString + sexString + "\n喜欢吃的水果：" + arr[0] + "," + arr[1]
        
        aLabel.numberOfLines = 0    // 需要换行的时候需要，高度设置为0
        aLabel.sizeToFit()
        self.view .addSubview(aLabel)
    
        
    
    }

    func studay(){
        let str = "hello,swift"
        str.lowercaseString
        let str1 : String = NSString(format: "%@", "好的") as String
        str1.lowercaseString
        
    }
    
    
    
    
    
    
}

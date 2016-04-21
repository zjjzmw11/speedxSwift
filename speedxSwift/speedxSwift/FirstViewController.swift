//
//  FirstViewController.swift
//  swiftDemo1
//
//  Created by xiaoming on 16/3/7.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit

class FirstViewController: BaseViewController {
    // ？ ！的区别
//    用变量之前，因为swift 没有给变量默认初始值
//    声明变量的时候加？相当于声明了一个 Optional类型的变量，想当然默认为空，调用方法的时候用 ？相当于判断如果为空就跳过调用，避免崩溃。
//    这里的!表示“我确定这里的的strValue一定是非nil的，尽情调用吧”
    
    
    
    var aScrollView:UIScrollView!
    var aLabel:UILabel!
    var aLabel2:UILabel!
    var aButton:UIButton!
    var aButton2:UIButton!
    var aView:UIView!
    var aImageView:UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化scrollView
        self.initScrollView()
        // 初始化UILabel
        self.initLabel()
        self.initLabel2()
        // 初始化按钮
        self.initButton()
        self.initButton2()
        // 初始化view
        self.initView()
        // 初始化图片
        self.initImageView()
        
    }

    func initScrollView() {
        aScrollView = UIScrollView()
        aScrollView.backgroundColor = UIColor.colorWithRGBA(200, G: 200, B: 200)
        aScrollView.frame = self.view.frame
        aScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight * 2)
        self.view.addSubview(aScrollView)
    }
    
    func initLabel() {
        aLabel = UILabel()
        aLabel.frame = CGRectMake(20, 20, 50, 30)
        aLabel.backgroundColor = UIColor.redColor()
        aLabel.text = "我是个UILabel长度是自适应的"
        aLabel.sizeToFit()
        self.aScrollView.addSubview(aLabel)
        // UILabel 添加点击事件
        let tap = UITapGestureRecognizer(target: self, action: Selector("aLabelAction"));
        aLabel.addGestureRecognizer(tap)
        aLabel.userInteractionEnabled = true
        
    }
    
    func aLabelAction() {
        print("点击的Label");
    }
    
    func initLabel2() {
        aLabel2 = initALabel(CGRectMake(20, 70, 50, 30), textString: "我是个UILabel2长度", font: UIFont.systemFontOfSize(20), textColor: UIColor.blueColor())
        self.aScrollView.addSubview(aLabel2)
    }
    
    func initButton() {
        aButton = UIButton()
        aButton.frame = CGRectMake(20, 100, 60, 30)
        aButton.backgroundColor = UIColor.blueColor()
        aButton .setTitle("按钮", forState: UIControlState.Normal)
        aButton .setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        aButton.titleLabel?.font = UIFont.systemFontOfSize(11)
        aButton.layer.cornerRadius = 5
        aButton.layer.masksToBounds = true;
        self.aScrollView.addSubview(aButton)
        // 按钮的点击事件
        aButton.addTarget(self, action: Selector("aButtonAction:"), forControlEvents: .TouchUpInside)
    }
    
    func aButtonAction(btn:UIButton){
        print(btn)
    }
    
    func initButton2() {
        aButton2 = initAButton(CGRectMake(200, 100, 120, 30), titleString: "按钮封装", font: UIFont.systemFontOfSize(20), textColor: UIColor.redColor(), bgImage: UIImage.init(named: "home_highlight")!)
        self.aScrollView.addSubview(aButton2)
    }
    
 
    func initView() {
        aView = UIView()
        aView.frame = CGRectMake(20, 150, 100, 100)
        aView.backgroundColor = UIColor.greenColor()
        self.aScrollView.addSubview(aView)
    }
    
    func initImageView() {
        aImageView = UIImageView()
        aImageView.frame = CGRectMake(0, 0, 100, 100)
        aImageView.image = UIImage.init(named: "account_highlight")
        aView.addSubview(aImageView)
    }
}

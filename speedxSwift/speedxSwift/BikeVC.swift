//
//  Brand_VC.swift
//  LBTabBar
//
//  Created by chenlei_mac on 15/8/25.
//  Copyright (c) 2015年 Bison. All rights reserved.
//

import UIKit

class BikeVC: BaseViewController {
    
    /// 本月里程值
    var distanceValueLabel : UILabel?
    /// 本月里程
    var distanceLabel : UILabel?
    // 开始骑行按钮
    var startButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "骑行"
        // 初始化控件
        self.myView()
    
    }

    func myView() {
        // 里程值
        distanceValueLabel = Tool.initALabel(CGRectMake(0, 30, kScreenWidth, 120), textString: "0", font: UIFont.boldSystemFontOfSize(90), textColor: UIColor.whiteColor())
        distanceValueLabel!.textAlignment = .Center
        self.view.addSubview(distanceValueLabel!)
        // 本月里程文字
        distanceLabel = Tool.initALabel(CGRectMake((distanceValueLabel!.left()), distanceValueLabel!.bottom(), distanceValueLabel!.width(), 30), textString: "总里程", font: UIFont.systemFontOfSize(16), textColor: UIColor.whiteColor())
        distanceLabel!.textAlignment = .Center
        self.view.addSubview(distanceLabel!)
        // 开始骑行按钮
        startButton = Tool.initAButton(CGRectMake(0, kScreenHeight - kTabBarHeight - kNavBarHeight - 100, 60, 60), titleString: "", font: UIFont.boldSystemFontOfSize(12), textColor: UIColor.clearColor(), bgImage: UIImage.init(named: "ridding_start_button_image")!)
        startButton?.center = CGPointMake(kScreenWidth/2, startButton!.centerY())
        self.view.addSubview(startButton!)
        

    }

}

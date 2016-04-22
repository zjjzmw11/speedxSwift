//
//  RidingVC.swift
//  speedxSwift
//
//  Created by speedx on 16/4/22.
//  Copyright © 2016年 speedx. All rights reserved.
//

import UIKit


class RidingVC: BaseViewController {

    /// 时间(t)
    var timeLabel : UILabel?
    /// 时间的Value - 03:01:40
    var timeValueLabel : UILabel?
    /// 实时速度(km/h)
    var speedLabel : UILabel?
    /// 实时速度值 0.00
    var speedValueLabel : UILabel?
    /// 里程(km)
    var distanceLabel : UILabel?
    /// 里程值 - 0.00
    var distanceValueLabel : UILabel?
    
    /// 完成、启动/恢复、地图 三个按钮
    var doneButton : UIButton?
    var startOrPauseButton : UIButton?
    var mapButton : UIButton?
    
    let spacing = (kScreenHeight - 100 - 340 - 30)/3.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        // 初始化UI
        self.initMyView()
        
        
        
        
    }
    
    /// 初始化UI 
    func initMyView() {
        // 时间(t)
        timeLabel = Tool.initALabel(CGRectMake(0, 40, kScreenWidth, 20), textString: "时间(t)", font: UIFont.boldSystemFontOfSize(16), textColor: UIColor.whiteColor())
        timeLabel?.textAlignment = .Center
        self.view.addSubview(timeLabel!)
        // 时间的Value - 03:01:40
        timeValueLabel = Tool.initALabel(CGRectMake(0, (timeLabel?.bottom()!)!, kScreenWidth, 80), textString: "00:00:00", font: UIFont.boldSystemFontOfSize(70), textColor: UIColor.whiteColor())
        timeValueLabel?.textAlignment = .Center
        self.view.addSubview(timeValueLabel!)
        
        // 实时速度(km/h)
        speedLabel = Tool.initALabel(CGRectMake(0, timeValueLabel!.bottom() + spacing, kScreenWidth, 20), textString: "实时速度(km/h)", font: UIFont.boldSystemFontOfSize(16), textColor: UIColor.whiteColor())
        speedLabel?.textAlignment = .Center
        self.view.addSubview(speedLabel!)
        // 实时速度值 0.00
        speedValueLabel = Tool.initALabel(CGRectMake(0, (speedLabel?.bottom()!)!, kScreenWidth, 120), textString: "0.00", font: UIFont.boldSystemFontOfSize(110), textColor: UIColor.whiteColor())
        speedValueLabel?.textAlignment = .Center
        self.view.addSubview(speedValueLabel!)
        
        // 里程(km)
        distanceLabel = Tool.initALabel(CGRectMake(0, speedValueLabel!.bottom() + spacing, kScreenWidth, 20), textString: "里程(km)", font: UIFont.boldSystemFontOfSize(16), textColor: UIColor.whiteColor())
        distanceLabel?.textAlignment = .Center
        self.view.addSubview(distanceLabel!)
        // 里程值 0.00
        distanceValueLabel = Tool.initALabel(CGRectMake(0, (distanceLabel?.bottom()!)!, kScreenWidth, 80), textString: "0.00", font: UIFont.boldSystemFontOfSize(70), textColor: UIColor.whiteColor())
        distanceValueLabel?.textAlignment = .Center
        self.view.addSubview(distanceValueLabel!)

        /// 完成、启动/恢复、地图 三个按钮
        doneButton = Tool.initAButton(CGRectMake(20, kScreenHeight - 100, 80, 80), titleString: "", font: UIFont.boldSystemFontOfSize(12), textColor: UIColor.clearColor(), bgImage: UIImage.init())
        doneButton?.setImage(UIImage.init(named: "riding_done"), forState: UIControlState.Normal)
        self.view.addSubview(doneButton!)
        doneButton?.addTarget(self, action: #selector(RidingVC.doneAction), forControlEvents: UIControlEvents.TouchUpInside)
        // 启动/恢复
        startOrPauseButton = Tool.initAButton(CGRectMake((doneButton?.right())!, doneButton!.top(), doneButton!.width(), doneButton!.height()), titleString: "", font: UIFont.boldSystemFontOfSize(12), textColor: UIColor.clearColor(), bgImage: UIImage.init())
        startOrPauseButton?.setImage(UIImage.init(named: "riding_pause"), forState: UIControlState.Normal)
        startOrPauseButton?.center = CGPointMake(self.view.centerX(), startOrPauseButton!.centerY())
        self.view.addSubview(startOrPauseButton!)
        startOrPauseButton?.addTarget(self, action: #selector(RidingVC.startOrPauseAction), forControlEvents: UIControlEvents.TouchUpInside)
        // 地图
        mapButton = Tool.initAButton(CGRectMake(kScreenWidth - doneButton!.width() - 20, doneButton!.top(), doneButton!.width(), doneButton!.height()), titleString: "", font: UIFont.boldSystemFontOfSize(12), textColor: UIColor.clearColor(), bgImage: UIImage.init())
        mapButton?.setImage(UIImage.init(named: "riding_map"), forState: UIControlState.Normal)
        self.view.addSubview(mapButton!)
        mapButton?.addTarget(self, action: #selector(RidingVC.mapAction), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    /// 完成骑行方法
    func doneAction() {
        print("完成骑行")
        
    }
    /// 启动或者暂停方法
    func startOrPauseAction() {
        print("启动骑行")
        
    }
    /// 地图方法
    func mapAction() {
        print("地图")
        let detailVC = CyclingMapViewVC()
        self.presentViewController(detailVC, animated: true, completion: nil)

        
    }
}

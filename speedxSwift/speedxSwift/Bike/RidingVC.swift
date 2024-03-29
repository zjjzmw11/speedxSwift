//
//  RidingVC.swift
//  speedxSwift
//
//  Created by speedx on 16/4/22.
//  Copyright © 2016年 speedx. All rights reserved.
//

import UIKit
import MapKit

class RidingVC: BaseViewController,CLLocationManagerDelegate,MKMapViewDelegate,UIAlertViewDelegate,CyclingManagerProtocol{

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
    
    /// 骑行管理单例
    var cycManager = CyclingManager.getCyclingManager()
    /// 当前坐标点
    var currentCLLocation : CLLocation?
    /// 点数组
    var points : NSMutableArray?
    /// 定时器
    var myTimer : NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        // 初始化UI
        self.initMyView()
        // 设置位置更新的代理-------
        self.cycManager.cycUIDelegate = self
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
        
        self.timeValueLabel!.font = UIFont.init(name: kMyFontName, size: 70)!
        self.speedValueLabel!.font = UIFont.init(name: kMyFontName, size: 110)!
        self.distanceValueLabel!.font = UIFont.init(name: kMyFontName, size: 70)!
    }
    
    /// 完成骑行方法
    func doneAction() {
        let alertV = UIAlertView.init(title: "确定结束骑行?", message: "", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
        alertV.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            print("继续骑行")
            cycManager.myTimer?.invalidate()
            cycManager.myTimer = nil
            cycManager.myTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: cycManager, selector: #selector(myTimerAction), userInfo: nil, repeats: true)
        }else{
            print("完成骑行")
            cycManager.cyclingType = 5 //完成
            cycManager.myTimer?.invalidate()
            cycManager.myTimer = nil
            cycManager.locationManager.stopUpdatingLocation() // 关闭定位
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    /// 启动或者暂停方法----------------------------------起点
    func startOrPauseAction() {
        print("启动骑行")
        cycManager.cyclingType = 1 // 启动
        cycManager.myTimer?.invalidate()
        cycManager.myTimer = nil
        cycManager.myTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: cycManager, selector: #selector(myTimerAction), userInfo: nil, repeats: true)

        cycManager.locationManager.startUpdatingLocation() // 开启定位
        
        /// 第一次开启的时候，初始化骑行model---------------------------------------------
        self.initActivityAction()
        
    }
    /// 初始化当前骑行记录的数据
    func initActivityAction() {
        self.cycManager.currentActivity.activityId = String(format: "IOS_%ld",arc4random())
        self.cycManager.currentActivity.userId = "1" // 暂时这样
        self.cycManager.currentActivity.title = "测试骑行"
        self.cycManager.currentActivity.isSyn = false
        self.cycManager.currentActivity.isFinished = false
        self.cycManager.currentActivity.isFake = false
        self.cycManager.currentActivity.startTime = NSDate()
        self.cycManager.currentActivity.endTime = NSDate()
        self.cycManager.currentActivity.avgSpeed = 0
        self.cycManager.currentActivity.maxSpeed = 0
        self.cycManager.currentActivity.totalDistance = 0
    }
    /// 更新当前骑行记录的数据
    func updateActivityAction() {
        self.cycManager.currentActivity.isSyn = false
        self.cycManager.currentActivity.isFinished = false
        self.cycManager.currentActivity.isFake = false
        self.cycManager.currentActivity.startTime = NSDate()
        self.cycManager.currentActivity.endTime = NSDate()
        self.cycManager.currentActivity.avgSpeed = 0
        self.cycManager.currentActivity.maxSpeed = 0
        self.cycManager.currentActivity.totalDistance = 0
    }
    
    func myTimerAction() {
        print("没有的方法")
    }
    
    /// 地图方法
    func mapAction() {
        print("地图")
        let detailVC = CyclingMapViewVC()
        self.presentViewController(detailVC, animated: true, completion: nil)
        
    }
    
    /// ----------代理方法---位置更新
    func didUpdateUIAction(){
        print("更新速度、距离、时间")
        /// 刷新 速度、距离、时间
        self.speedValueLabel?.text = String(format: "%.2f",cycManager.speed!*3.6)
        self.distanceValueLabel?.text = String(format: "%.2f",cycManager.distance!/1000.0)
        
        // 时、分、秒
        let h = cycManager.time!/3600
        let m = cycManager.time!%3600/60
        let s = cycManager.time!%3600%60
        
        var hString = String(format: "%d", h)
        if h < 10 {
            hString = String(format: "0%d", h)
        }
        var mString = String(format: "%d", m)
        if m < 10 {
            mString = String(format: "0%d", m)
        }
        var sString = String(format: "%d", s)
        if s < 10 {
            sString = String(format: "0%d", s)
        }

        self.timeValueLabel?.text = String(format: "%@:%@:%@",hString,mString,sString)

    }
    func didUpdateAction(loca: CLLocation, pointArray: NSMutableArray) {
        
    }
}

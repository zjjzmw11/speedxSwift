//
//  Shoping_VC.swift
//  LBTabBar
//
//  Created by chenlei_mac on 15/8/25.
//  Copyright (c) 2015年 Bison. All rights reserved.
//

import UIKit


class ClubVC: BaseViewController {
    
    let BaiduURL = kHOME_TOPIC_LIST_URL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "俱乐部"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //网络请求
        self.reloadData()
    }
    
    
    func reloadData(){
//        http://api.map.baidu.com/telematics/v3/weather?location=嘉兴&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ
        let url = "http://api.map.baidu.com/telematics/v3/weather?location=北京&output=json&ak=yourkey"
        
        RequestBaseManager .baseRequestJson(.GET, urlString: url) { (isSuccessed, code, jsonValue) in
            print("isSuccessed====\(isSuccessed)")
            print("code====\(code)")
            print("jsonValue====\(jsonValue)")

        }
    
    }
}

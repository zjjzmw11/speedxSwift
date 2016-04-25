//
//  Shoping_VC.swift
//  LBTabBar
//
//  Created by chenlei_mac on 15/8/25.
//  Copyright (c) 2015年 Bison. All rights reserved.
//

import UIKit
import Alamofire

class ClubVC: BaseViewController {
    
    let BaiduURL = kHOME_TOPIC_LIST_URL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "俱乐部"
        
        //网络请求
        self .reloadData()
    }
    
    func reloadData(){
    
        Alamofire.request(.POST, BaiduURL, parameters:nil ).responseJSON {response in
            
            switch response.result {
            case .Success:
                //把得到的JSON数据转为字典
                if let j = response.result.value as? NSDictionary{
                    //获取字典里面的key为数组
                    let Items = j.valueForKey("result")as! NSArray
                    //便利数组得到每一个字典模型
                    for dict in Items{
                        
                        print(dict)
                    }
                    
                }
            case .Failure(let error):
                
                print(error)
            }
        }
    }
}

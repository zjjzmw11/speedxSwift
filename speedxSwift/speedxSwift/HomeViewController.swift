//
//  HomeViewController.swift
//  swiftDemo1
//
//  Created by xiaoming on 16/3/7.
//  Copyright © 2016年 shandandan. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    // 表格数据
    let arr = ["简单变量操作","控件大全","webView","请求","Polyline"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        
        // 初始化表格
        let tableView = UITableView(frame: CGRectMake(0, 0, kScreenWidth, kScreenHeight), style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view .addSubview(tableView)
        
        // Class 注册
        tableView.registerClass(HomeCell.self, forCellReuseIdentifier: "HomeCellID")
    
        
        
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 原生的cell
//        var cell = tableView.dequeueReusableCellWithIdentifier("kMyTableViewCell") as UITableViewCell!
//        if cell == nil {
//            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "kMyTableViewCell")
//        }
//        cell?.textLabel?.text = arr[indexPath.row]
//        return cell!;
        
        // 自定义cell
        var cell:HomeCell!
        cell = tableView.dequeueReusableCellWithIdentifier("HomeCellID") as! HomeCell
        
        cell.indexP = indexPath
        cell?.testLabel?.text = arr[indexPath.row]
        cell.testLabel .sizeToFit()
        if indexPath.row == 0 {
            cell.testButton.hidden = true
        }
        
        cell.buttonClickBlock = {
            (ind,btn) -> () in
            print(indexPath.row)
            print(btn.currentTitle!)
        }
        
        return cell!
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print(indexPath.row)
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        var detailVC : UIViewController?
//        if indexPath.row == 0 {// 简单变量操作
//            detailVC = SimpleViewController()
//        }else if indexPath.row == 1 {// 控件大全
//            detailVC = FirstViewController()
//        }else if indexPath.row == 2 {// webView
//            detailVC = WebViewController()
//        }else if indexPath.row == 3 {// 请求
//            detailVC = NetWorkViewController()
//        }else if indexPath.row == 4 {// polyline 测试
//            // 测试谷歌的polyLine
//            let encodedPolyline = "_p~iF~ps|U_ulLnnqC_mqNvxq`@"
//            
//            let coordinates : [CLLocationCoordinate2D]? = Polyline.decodePolyline(encodedPolyline)
//            
//            for  coor:CLLocationCoordinate2D in coordinates! {
//                print("lon= \(coor.longitude) lat===\(coor.latitude) ")
//            }
//        }
//        if detailVC != nil {
//            self.navigationController!.pushViewController(detailVC!, animated: true)
//        }
    }

    
}

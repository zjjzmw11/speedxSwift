//
//  LBNvc.swift
//  SayGift
//
//  Created by chenlei_mac on 15/8/24.
//  Copyright (c) 2015年 Bison. All rights reserved.
//

import UIKit

class LBNvc: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.whiteColor(),forKey: NSForegroundColorAttributeName)
        self.navigationBar.titleTextAttributes = navigationTitleAttribute as [NSObject : AnyObject] as? [String : AnyObject]
        self.navigationBar .setBackgroundImage(UIImage.imageWithColor(kSpeedX_Color_Navigation_Bg, size: CGSizeMake(kScreenWidth, 64)), forBarMetrics: .Default)
        
    }
}

//
//  CustomTabBar.swift
//  SayGift
//
//  Created by chenlei_mac on 15/8/24.
//  Copyright (c) 2015年 Bison. All rights reserved.
//

import UIKit

class CustomTabBar: UITabBarController {
    
    class func CusTomTabBar() ->UITabBarController{
        
        let vc1 = HomeVC()     // 我
        let vc2 = RankVC()    // 排行榜
        let vc3 = BikeVC()    // 骑行
        let vc4 = ClubVC()  // 俱乐部
        let vc5 = MoreVC() // 更多
        let nvc1:UINavigationController = LBNvc(rootViewController: vc1)
        let nvc2:UINavigationController = LBNvc(rootViewController: vc2)
        let nvc3:UINavigationController = LBNvc(rootViewController: vc3)
        let nvc4:UINavigationController = LBNvc(rootViewController: vc4)
        let nvc5:UINavigationController = LBNvc(rootViewController: vc5)
        let tabbar1 = UITabBarItem(title: "我", image: (Public .getImgView("tabbar_me")) , selectedImage: (Public .getImgView("tabbar_me_selected")))
        let tabbar2 = UITabBarItem(title: "排行榜", image: (Public .getImgView("tabbar_rank")), selectedImage: (Public .getImgView("tabbar_rank_selected")))
        let tabbar3 = UITabBarItem(title: "骑行", image: (Public .getImgView("tabbar_ridding")), selectedImage: (Public .getImgView("tabbar_ridding_selected")))
        let tabbar4 = UITabBarItem(title: "俱乐部", image: (Public .getImgView("tabbar_club")), selectedImage: (Public .getImgView("tabbar_club_selected")))
        let tabbar5 = UITabBarItem(title: "更多", image: (Public .getImgView("tabbar_more")), selectedImage: (Public .getImgView("tabbar_more_selected")))
        nvc1.tabBarItem = tabbar1;
        nvc2.tabBarItem = tabbar2;
        nvc3.tabBarItem = tabbar3;
        nvc4.tabBarItem = tabbar4;
        nvc5.tabBarItem = tabbar5;
        let tc = UITabBarController()
        
        tc.tabBar.tintColor = UIColor .redColor()
//        tc.tabBar.backgroundImage = Public.getImgView("3.png")
        tc.viewControllers = [nvc1,nvc2,nvc3,nvc4,nvc5];
        return tc;
    }

}

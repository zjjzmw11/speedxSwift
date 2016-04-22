//
//  CyclingMapViewVC.swift
//  speedxSwift
//
//  Created by speedx on 16/4/22.
//  Copyright © 2016年 speedx. All rights reserved.
//

import MapKit
import UIKit

class CyclingMapViewVC: BaseViewController,MKMapViewDelegate,CyclingManagerProtocol {

    /// 当前地图
    var mapView : MKMapView!
    /// 回到当前点的按钮
    var currentButton : UIButton?
    /// 返回按钮
    var backButton : UIButton?
    /// 当前坐标点
    var currentCLLocation : CLLocation?
    /// 当前线
    var routeLine : MKPolyline?
    /// 点数组
    var points : NSMutableArray?
    /// 骑行管理
    var cycManager = CyclingManager.getCyclingManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化地图UI
        self .initMyMapView()
        // 设置位置更新的代理-------
        self.cycManager.cycDelegate = self
        
    }
    // 初始化地图 UI 
    func initMyMapView() {
        mapView = MKMapView(frame: self.view.frame)
        mapView.mapType = .Standard
        mapView.userTrackingMode = .Follow
        // 显示定位当前点
        self.mapView.showsUserLocation = true
        // 划线 rendererForOverlay 代理方法执行，设置颜色。粗细 MKMapViewDelegate
        self.mapView.delegate = self
        self.view.addSubview(mapView!)
        
        
        // 当前按钮
        currentButton = Tool.initAButton(CGRectMake(20, kScreenHeight - 100, 80, 80), titleString: "", font: UIFont.boldSystemFontOfSize(12), textColor: UIColor.clearColor(), bgImage: UIImage.init())
        currentButton?.setImage(UIImage.init(named: "riding_done"), forState: UIControlState.Normal)
        self.view.addSubview(currentButton!)
        currentButton?.addTarget(self, action: #selector(CyclingMapViewVC.currentLocationAction), forControlEvents: UIControlEvents.TouchUpInside)
        // 返回按钮
         backButton = Tool.initAButton(CGRectMake(kScreenWidth - currentButton!.width() - 20, currentButton!.top(), currentButton!.width(), currentButton!.height()), titleString: "", font: UIFont.boldSystemFontOfSize(12), textColor: UIColor.clearColor(), bgImage: UIImage.init())
        backButton?.setImage(UIImage.init(named: "riding_map"), forState: UIControlState.Normal)
        self.view.addSubview(backButton!)
        backButton?.addTarget(self, action: #selector(CyclingMapViewVC.backAction), forControlEvents: UIControlEvents.TouchUpInside)
    }
    /// 地图方法
    func backAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /// 回到当前点
    func currentLocationAction() {
        if self.currentCLLocation != nil {
            self.mapView.setCenterCoordinateLevel(self.currentCLLocation!.coordinate, zoomLevel: 15, animated: true)
        }
    }
    /// ----------代理方法---位置更新
    func didUpdateAction(loca: CLLocation) {
        print("更新位置----地图---------代理传过来的")
        self.currentCLLocation = loca
        
        if self.points == nil {
            self.points = NSMutableArray()
        }
        self.points?.addObject(loca)
        // 划线
        self.routeLine = polyline()
        if self.routeLine != nil {
            self.mapView.addOverlay(self.routeLine!)
        }
    }
    
    // -----------------------------------划线---------------------------------
    /// 划线的颜色和宽度
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.redColor()
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return MKOverlayRenderer()
    }
    /// 划线
    func polyline() -> MKPolyline {
        var coords = [CLLocationCoordinate2D]()
        for var i = 0 ; i < self.points?.count ; i += 1 {
            let userLocation = self.points!.objectAtIndex(i) as! CLLocation
            let coor = userLocation.coordinate
            coords.append(coor)
        }
        return MKPolyline(coordinates: &coords, count: self.points!.count)
    }
    
    
}

/// 设置地图缩放等级
extension MKMapView {
    
    var MERCATOR_OFFSET:Double {
        return 268435456.0
    }
    var MERCATOR_RADIUS:Double {
        return 85445659.44705395
    }
    
    public func setCenterCoordinateLevel(centerCoordinate:CLLocationCoordinate2D,zoomLevel:Double,animated:Bool) {
        //设置最小缩放级别
        let lastZoomLevel  = min(zoomLevel, 22)
        
        let span   = self.coordinateSpanWithMapView(self, centerCoordinate: centerCoordinate, zoomLevel: lastZoomLevel);
        let region = MKCoordinateRegionMake(centerCoordinate, span);
        
        self.setRegion(region, animated: animated)
        
    }
    
    func longitudeToPixelSpaceX(longitude:Double) ->Double {
        return round(MERCATOR_OFFSET + MERCATOR_RADIUS * longitude * M_PI / 180.0)
    }
    
    func latitudeToPixelSpaceY(latitude:Double) ->Double {
        return round(MERCATOR_OFFSET - MERCATOR_RADIUS * log((1 + sin(latitude * M_PI / 180.0)) / (1 - sin(latitude * M_PI / 180.0))) / 2.0)
    }
    
    func pixelSpaceXToLongitude(pixelX:Double) ->Double {
        return ((round(pixelX) - MERCATOR_OFFSET) / MERCATOR_RADIUS) * 180.0 / M_PI
    }
    
    func pixelSpaceYToLatitude(pixelY:Double) ->Double {
        return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - MERCATOR_OFFSET) / MERCATOR_RADIUS))) * 180.0 / M_PI
    }
    
    func coordinateSpanWithMapView(mapView:MKMapView,
                                   centerCoordinate:CLLocationCoordinate2D,
                                   zoomLevel:Double) -> MKCoordinateSpan
    {
        let centerPixelX = self.longitudeToPixelSpaceX(centerCoordinate.longitude)
        let centerPixelY = self.latitudeToPixelSpaceY(centerCoordinate.latitude)
        let zoomExponent = 20.0 - zoomLevel
        let zoomScale = pow(2.0, zoomExponent)
        
        let mapSizeInPixels = mapView.bounds.size
        let scaledMapWidth  = Double(mapSizeInPixels.width) * zoomScale
        let scaledMapHeight = Double(mapSizeInPixels.height) * zoomScale
        
        let topLeftPixelX = centerPixelX - (scaledMapWidth/2)
        let topLeftPixelY = centerPixelY - (scaledMapHeight/2)
        
        let minLng = self.pixelSpaceXToLongitude(topLeftPixelX)
        let maxLng = self.pixelSpaceXToLongitude(topLeftPixelX + scaledMapWidth)
        let longitudeDelta = maxLng - minLng
        
        let minLat = self.pixelSpaceYToLatitude(topLeftPixelY);
        let maxLat = self.pixelSpaceYToLatitude(topLeftPixelY + scaledMapHeight);
        let latitudeDelta = -1 * (maxLat - minLat);
        
        let span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        return span
    }
}

































//
//  Map.swift
//  実習
//
//  Created by 境聖也 on 2016/05/23.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Map: UIViewController,
CLLocationManagerDelegate{
    //UIImageViewを作成する
    let myImageView = UIImageView(frame: CGRectMake(0,0,300,300))
    
    var locationMgr : CLLocationManager
    //初期化処理
    required init(coder aDecoder: NSCoder){
        locationMgr = CLLocationManager()
        
        super.init(coder: aDecoder)!
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //表示する画像を設定する
        let myImage = UIImage(named: "arrow.jpg")
        
        //画像をUIImageViewに設定する
        myImageView.image = myImage
        
        //画像を表示する座標を指定する
        myImageView.layer.position =
            CGPoint(x: self.view.bounds.width / 2,y: 200.0)
        
        //UIImageViewをViewに追加する
        self.view.addSubview(myImageView)
        
        locationMgr.delegate = self
        locationMgr.headingFilter = kCLHeadingFilterNone
        locationMgr.headingOrientation = CLDeviceOrientation.Portrait
        
        locationMgr.startUpdatingHeading()
    }
    
    func locationManager(manager: CLLocationManager,
                         didUpdateHeading newHeading: CLHeading){
        //回転角度の計算
        let rt = -CGFloat(2 * M_PI * newHeading.magneticHeading / 360.0)
        
        //画像を回転させる
        myImageView.transform =
            CGAffineTransformMakeRotation(rt)
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
}


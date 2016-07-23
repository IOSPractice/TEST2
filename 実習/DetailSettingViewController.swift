//
//  File.swift
//  実習
//
//  Created by 大木一輝 on 2016/07/02.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class DetailSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var detailTableView: UITableView!
    
    let stationTitles = ["高坂", "北坂戸", "熊谷"]
    
    var takasakaSwch: UISwitch!
    var kitasakadoSwch: UISwitch!
    var kumagayaSwch: UISwitch!
    var notifSwch: UISwitch!
    
    override func viewDidLoad() {
        
    }
    
    
    //セクションごとのセル数の設定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return stationTitles.count
        } else if section == 1 {
            return 1
        }
        
        return 0
    }
    
    //セクション数の設定
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    
    //セクションの高さの設定
    func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellDetail")
        
        switch indexPath.section {
        case 0:
            cell?.textLabel?.text = "\(stationTitles[indexPath.row])"
            let realm = try! Realm()
            let destStation = realm.objects(BusDestinationData).first!
            
            switch indexPath.row {
            case 0:
                takasakaSwch = UISwitch()
                takasakaSwch.on = destStation.takasaka
                takasakaSwch.addTarget(self, action: #selector(DetailSettingViewController.switchAction(_:)), forControlEvents: .ValueChanged)
                cell?.accessoryView = UIView(frame: takasakaSwch.frame)
                cell?.accessoryView?.addSubview(takasakaSwch)
            case 1:
                kitasakadoSwch = UISwitch()
                kitasakadoSwch.on = destStation.kitasakado
                kitasakadoSwch.addTarget(self, action: #selector(DetailSettingViewController.switchAction(_:)), forControlEvents: .ValueChanged)
                cell?.accessoryView = UIView(frame: kitasakadoSwch.frame)
                cell?.accessoryView?.addSubview(kitasakadoSwch)
            case 2:
                kumagayaSwch = UISwitch()
                kumagayaSwch.on = destStation.kumagaya
                kumagayaSwch.addTarget(self, action: #selector(DetailSettingViewController.switchAction(_:)), forControlEvents: .ValueChanged)
                cell?.accessoryView = UIView(frame: kumagayaSwch.frame)
                cell?.accessoryView?.addSubview(kumagayaSwch)

            default:
                break
            }
            
        case 1:
            cell?.textLabel?.text = "バス通知の設定"
            notifSwch = UISwitch()
            notifSwch.addTarget(self, action: #selector(DetailSettingViewController.notificationSwitching(_:)), forControlEvents: .ValueChanged)
            //TODO: notifSwch.on = true
            cell?.accessoryView = UIView(frame: notifSwch.frame)
            cell?.accessoryView?.addSubview(notifSwch)
        default:
            break
        }
        
        return cell!
    }
    
    func switchAction(sender: UISwitch) {
        let realm = try! Realm()
        let destStations = realm.objects(BusDestinationData)
        
        if let dest = destStations.first {//取り出した値がnilでなければ値を更新する
            if sender == takasakaSwch {
                try! realm.write() {
                    dest.takasaka = sender.on
                }
            } else if sender == kitasakadoSwch {
                try! realm.write() {
                    dest.kitasakado = sender.on
                }
            } else if sender == kumagayaSwch {
                try! realm.write() {
                    dest.kumagaya = sender.on
                }
            }
        }
    }
    
    func notificationSwitching(sender: UISwitch) {

        print("Switching ...")
        if sender.on == true {
            //バスの通知を登録
            MyLocalNotification().setNotificationBustimes()
        } else {
            UIApplication.sharedApplication().cancelAllLocalNotifications()
        }
    }
}
//
//  File.swift
//  実習
//
//  Created by 大木一輝 on 2016/07/02.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation
import UIKit

class DetailSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var detailTableView: UITableView!
    
    let stationTitles = ["高坂", "北坂戸", "熊谷"]
    
    var takasakaSwch: UISwitch!
    var kitasakadoSwch: UISwitch!
    var kumagayaSwch: UISwitch!
    var notifSwch: UISwitch!
    
    override func viewDidLoad() {
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellDetail")
        
        switch indexPath.section {
        case 0:
            cell?.textLabel?.text = "\(stationTitles[indexPath.row])"
            
            switch indexPath.row {
            case 0:
                takasakaSwch = UISwitch()
                //TODO:takasakaSwch.on = true
                takasakaSwch.addTarget(self, action: #selector(DetailSettingViewController.switchAction(_:)), forControlEvents: .ValueChanged)
                cell?.accessoryView = UIView(frame: takasakaSwch.frame)
                cell?.accessoryView?.addSubview(takasakaSwch)
            case 1:
                kitasakadoSwch = UISwitch()
                //TODO:kitasakadoSwch.on = true
                kitasakadoSwch.addTarget(self, action: #selector(DetailSettingViewController.switchAction(_:)), forControlEvents: .ValueChanged)
                cell?.accessoryView = UIView(frame: kitasakadoSwch.frame)
                cell?.accessoryView?.addSubview(kitasakadoSwch)
            case 2:
                kumagayaSwch = UISwitch()
                //TODO:kumagayaSwch.on = true
                kumagayaSwch.addTarget(self, action: #selector(DetailSettingViewController.switchAction(_:)), forControlEvents: .ValueChanged)
                cell?.accessoryView = UIView(frame: kumagayaSwch.frame)
                cell?.accessoryView?.addSubview(kumagayaSwch)

            default:
                break
            }
            
        case 1:
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
        
    }
    
    func notificationSwitching(sender: UISwitch) {
        
    }
}
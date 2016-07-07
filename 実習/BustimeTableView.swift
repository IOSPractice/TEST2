//
//  BustimeTableView.swift
//  実習
//
//  Created by 大木一輝 on 2016/06/25.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class BustimeTableView: UITableView, UITableViewDelegate, UITableViewDataSource {

    var busDates: [(NSDate, String)] = []
    
    func initialize(bustimes: [(NSDate, String)]) {
        self.delegate = self
        self.dataSource = self
        self.busDates = bustimes
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return busDates.count
        } else if section == 1 {
            return 0
        } else {
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        view.tintColor = UIColor.clearColor()
    }
    
    // Footer の高さを返す
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 280
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell")
        let station = busDates[indexPath.row].1
        
        cell.textLabel?.text = "\(formatFromNSDate(busDates[indexPath.row].0))"
        cell.detailTextLabel?.text = "\(busDates[indexPath.row].1)駅行き"

        if station == "高坂" {
            cell.backgroundColor = UIColor(red: 43/255, green: 165/255, blue: 216/255, alpha: 0.5)
        } else if station == "北坂戸" {
            cell.backgroundColor = UIColor(red: 164/255, green: 199/255, blue: 114/255, alpha: 0.5)
        } else if station == "熊谷" {
            cell.backgroundColor = UIColor(red: 218/255, green: 165/255, blue: 184/255, alpha: 0.5)
        }
        
        return cell
    }
    
    
    //引数のNSDateを指定の書式にして文字列として返す
    func formatFromNSDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(name: "GMT")
        formatter.dateFormat = "HH:mm"
        return formatter.stringFromDate(date)
    }

}

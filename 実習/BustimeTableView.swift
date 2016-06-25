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
        return busDates.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "Cell") 
        
        cell.textLabel?.text = "\(formatFromNSDate(busDates[indexPath.row].0))"
        cell.detailTextLabel?.text = "\(busDates[indexPath.row].1)駅行き"
        
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

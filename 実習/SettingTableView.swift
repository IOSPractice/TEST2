//
//  SettingTableView.swift
//  実習
//
//  Created by 大木一輝 on 2016/06/25.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class SettingTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    let sectionTitle: [String] = ["表示設定", "詳細設定"]
    let numberOfRowsInSections: [Int] = [2, 1]
    
    func initialize() {
        self.delegate = self
        self.dataSource = self
    }
    
    //セクション数の設定
    override func numberOfRowsInSection(section: Int) -> Int {
        return sectionTitle.count
    }
    
    
    //セクションごとのセル数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSections[section]
    }
    
    
    //セクションのタイトル設定
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRectMake(0, 0, 200, 22))
        label.text = sectionTitle[section]
        label.font = UIFont.boldSystemFontOfSize(12)
        
        return label
    }
    
    
    //セクションの高さ設定
    func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    
    //セル内の値設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellSetting", forIndexPath: indexPath)
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.textLabel?.text = "現在時刻付近のバス時刻を表示する"
            } else {
                let datePicker = UIDatePicker()
                datePicker.frame = CGRectMake(0, 50, self.frame.width, 200)
                datePicker.timeZone = NSTimeZone(name: "GMT")
                datePicker.backgroundColor = UIColor.whiteColor()
                datePicker.addTarget(self, action: #selector(SettingTableView.changePickerValue(_:)), forControlEvents: .ValueChanged)
                //セルに追加
                cell.accessoryView = UIView(frame: datePicker.frame)
                cell.accessoryView?.addSubview(datePicker)
            }
        case 1: break
            
        default:
            break
            
        }
        return cell
    }
    
    func changePickerValue(sender: UIDatePicker) {
        
    }
}

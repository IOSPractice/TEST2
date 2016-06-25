//
//  SettingTableView.swift
//  実習
//
//  Created by 大木一輝 on 2016/06/25.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class SettingTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    func initialize() {
        self.delegate = self
        self.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellSetting", forIndexPath: indexPath)
        
        cell.textLabel?.text = "Menu: \(indexPath.row)"
        
        return cell
    }
}

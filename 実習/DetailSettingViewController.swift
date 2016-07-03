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
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellDetail")
        
        return cell!
    }
    
}
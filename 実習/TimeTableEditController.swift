//
//  TimeTableEditController.swift
//  実習
//
//  Created by 大木一輝 on 2016/06/10.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit
import RealmSwift

class TimeTableEditController: UIViewController {
    @IBOutlet weak var classNum: UITextField!
    @IBOutlet weak var className: UITextField!
    
    var classIndex: Int!

    @IBAction func addButton(sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdid")
        print("\(classIndex)")
    }
    
    
    //入力された授業名、教室が空欄でないことを確認
    private func isValidString() -> Bool {
        if className.text?.characters.count == 0 && classNum.text?.characters.count == 0 {
            return false
        } else {
            
            return true
        }
    }
    
    
}

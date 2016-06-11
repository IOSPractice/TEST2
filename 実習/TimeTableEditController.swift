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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdid")
        print("\(classIndex)")
    }

    
    @IBAction func addButton(sender: UIButton) {
        
    }
    
    
    //入力された授業名、教室が空欄でないことを確認
    private func isValidString() -> Bool {
        if className.text?.characters.count == 0 || classNum.text?.characters.count == 0 {
            return false
        } else {//入力が正常にされていればデータの追加および編集を行う
            let classData = ClassObject()
            classData.classNam = self.className.text!
            classData.classNum = self.classNum.text!
            classData.index = self.classIndex
            
            /*まずはこのindexで表される授業データがすでに存在しているかを確認する
             *データが存在していたら編集、存在していなかったら新規にデータを追加する
             */
            let realm = try! Realm()//defaultのrealmオブジェクトの取得
            
            
            return true
        }
    }
}

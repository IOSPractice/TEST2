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
    @IBOutlet weak var classLabel: UILabel!
    
    var classIndex: Int!
    let weekdays = ["月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
    
    
    override func viewDidLoad() {
        let realm = try! Realm()
        let object = realm.objects(ClassObject).filter("index == %@",self.classIndex)
        
        self.className.text = object.isEmpty ? "" : object[0].classNam
        self.classNum.text = object.isEmpty ? "" : object[0].classNum
        
        //編集画面に今どの時間の授業を編集しているかをここに表示する
        self.classLabel.text = getPeriodAndWeekday(classIndex)
    }

    
    @IBAction func addButton(sender: UIButton) {
        /*まずはこのindexで表される授業データがすでに存在しているかを確認する
         *データが存在していたら編集、存在していなかったら新規にデータを追加する
         */
        if isValidString() {//入力が有効の時の処理
            let classData = ClassObject()
            classData.classNam = self.className.text!
            classData.classNum = self.classNum.text!
            classData.index = self.classIndex
            
            //データの有無の確認
            let realm = try! Realm()
            let result = realm.objects(ClassObject).filter("index == %@",self.classIndex).first//realmオブジェクトからClassObjectの中からindexが同じものを取得する
            if (result == nil) {
                try! realm.write{//データの追加
                    realm.add(classData)
                }
            } else {//nilでないデータが返されていたらそのデータを編集する
                try! realm.write {
                    result?.classNam = self.className.text!
                    result?.classNum = self.classNum.text!
                }
            }
        }
        //元の画面に戻る
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //授業データの削除
    @IBAction func deleteButton(sender: UIButton) {
        let realm = try! Realm()
        let deleteData = realm.objects(ClassObject).filter("index == %@", self.classIndex)
        
        if !deleteData.isEmpty {//取得データがからでなければ削除を開始する
            try! realm.write{
                realm.delete(deleteData)
            }
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //入力された授業名、教室が空欄でないことを確認
    private func isValidString() -> Bool {
        if className.text?.characters.count == 0 || classNum.text?.characters.count == 0 {
            return false
        } else {//入力が正常にされていればデータの追加および編集を行う
            return true
        }
    }
    
    //引数の数字から曜日と時限を表した文字列を返す
    func getPeriodAndWeekday(index: Int) -> String? {
        var indexString: String!//ここに文字列を入れる
        let weekday = self.weekdays[index%6]
        if index > 35 {
            return nil
        }
        
        indexString = "\(weekday) \(Int(index/6) + 1)限"
        
        return indexString
    }
}

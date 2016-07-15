//
//  MyLocalNotification.swift
//  実習
//
//  Created by 大木一輝 on 2016/07/15.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MyLocalNotification: NSObject {
    var weekDay: Int!//インスタンスが生成された日の曜日
    
    override init() {
        super.init()
        weekDay = getWeekDay()//今日の曜日を整数値で取得
    }
    
    func getWeekDay() -> Int {
        let date: NSDate = NSDate()
        let cal: NSCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let comp: NSDateComponents = cal.components(
            [NSCalendarUnit.Weekday],
            fromDate: date
        )
        
        return comp.weekday
    }
}
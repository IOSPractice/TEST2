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
    var notification: UILocalNotification!
    
    override init() {
        super.init()
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        notification = UILocalNotification()
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
    
    func setNotificationBustimes() {
        let busItems = getBustimes()//バスの時刻表の取得
        
    }
    
    
    //授業データから本日の最後の授業を取得し、終了時刻を返す
    func getLastClassDate() -> NSDate {
        var retDate: NSDate!
        let weekDay = getWeekDay()//今日の曜日を取得
        let realm = try! Realm()
        
        //今日の授業データを取得
        let todayClasses = realm.objects(ClassObject).filter("index % 6 == %d", weekDay)
    
        return retDate
    }
    
    func getBustimes() -> [(NSDate, String)] {
        //プロジェクト内のplistファイルを読み込む
        let path: String = NSBundle.mainBundle().pathForResource("bustime", ofType: "plist")!
        let plist: NSDictionary = NSDictionary(contentsOfFile: path)!
        
        //各駅の時刻表を読み込む
        let takasaka = (plist.objectForKey("高坂") as! NSArray)
        let kitasakado = (plist.objectForKey("北坂戸") as! NSArray)
        let kumagaya = (plist.objectForKey("熊谷") as! NSArray)
        
        
        var dateItems = self.pickUpDateFromNSArray(takasaka, station: "高坂")
        dateItems += self.pickUpDateFromNSArray(kitasakado, station: "北坂戸")
        dateItems += self.pickUpDateFromNSArray(kumagaya, station: "熊谷")
        
        dateItems.sortInPlace {$0.0.timeIntervalSince1970 < $1.0.timeIntervalSince1970}

        return dateItems
    }
    
    //NSArrayに格納されている文字列の時間をNSDate型に変換し、配列で返す
    func pickUpDateFromNSArray(bustime: NSArray, station: String) -> [(NSDate, String)] {
        var bustimeDates: [(NSDate, String)] = []
        
        for item in bustime {
            let dateItem = self.setHourAndMinuteFromString(item as! String)
            bustimeDates.append((dateItem, station))
        }
        
        return bustimeDates
    }
    
    
    //文字列の時間をNSDate型にセットする
    func setHourAndMinuteFromString(stringDate: String) -> NSDate {
        var retDate: NSDate = NSDate()//現在時刻の取得
        
        //文字列時刻を":"で分割し、Int型に変換する
        let separated = stringDate.componentsSeparatedByString(":")
        let hour: Int = Int(separated[0])!
        let minute: Int = Int(separated[1])!
        
        //retDateからyear,month,day,hour,minuteを取得し、hour,minuteをretDateにセットする
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComps: NSDateComponents = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: retDate)
        dateComps.timeZone = NSTimeZone(name: "GMT")
        dateComps.hour = hour
        dateComps.minute = minute
        dateComps.second = 0
        retDate = calendar.dateFromComponents(dateComps)!
        
        return retDate
    }


}
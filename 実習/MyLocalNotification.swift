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
    let dateString: [String] = ["11:00", "12:40", "15:00", "16:40", "18:20", "20:00"]//各授業の終了時刻
    var notification: UILocalNotification!
    
    override init() {
        super.init()
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
    }
    
    
    //今日の授業データから最後の授業終了時刻以降のバスの時刻を三つほど返す
    func setNotificationBustimes() {
        let busItems = getBustimes()//バスの時刻表の取得
        let lastDate = getLastClassDate()//その日の最後の授業の終了時刻を取得
        var busCount = 0//バスの通知数をカウント
        
        for item in busItems {

            if lastDate?.compare(item.0) == NSComparisonResult.OrderedAscending && busCount < 3 {
                self.schedule(item)
                print("\(formatFromNSDate(item.0))")
                busCount += 1
            } else if busCount >= 3 {
                break
            }
        }
    }
    
    
    //引数のバスデータの10分前に通知が発せられるようにセット
    private func schedule(busData: (NSDate, String)) {
        let notification = UILocalNotification()
        
        notification.fireDate = busData.0.before(.Minute, duration: 10)
        notification.timeZone = NSTimeZone(name: "GMT")
        notification.alertBody = "\(busData.1)駅行き\(formatFromNSDate(busData.0))発)"
        notification.alertAction = "アプリを起動"
        notification.soundName = UILocalNotificationDefaultSoundName

        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    
    //今日の曜日を取得する
    private func getWeekDay() -> Int {
        let date: NSDate = NSDate()
        let cal: NSCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        let comp: NSDateComponents = cal.components(
            [NSCalendarUnit.Weekday],
            fromDate: date
        )
        
        return comp.weekday
    }

    
    
    //授業データから本日の最後の授業を取得し、終了時刻を返す
    private func getLastClassDate() -> NSDate! {
        var retDate: NSDate!
        let weekDay = getWeekDay() - 2//今日の曜日を取得し、変換
        let realm = try! Realm()
        var todayClasses:[ClassObject] = []
        let classes = Array(realm.objects(ClassObject))
        
        if weekDay >= 6 {//日曜日はサポートしません
            return nil
        }
        
        //今日の授業を授業データの中から取り出す。
        for item in classes {
            for var i in 0 ... 5 {
                if item.index == ((weekDay % 6) + i*6) {
                    todayClasses.append(item)
                }
            }
        }
        
        if !todayClasses.isEmpty {
            //取り出したデータの最後を取得
            let todayLastClass = todayClasses.last!
            print("最後の授業は\(todayLastClass.classNam)")
            //取り出したデータのindexから最後の時間を調べる
            let index = Int(todayLastClass.index / 6)
            retDate = setHourAndMinuteFromString(dateString[index])
            
        } else {
            return nil
        }
        
        return retDate
    }
    
    
    private func getBustimes() -> [(NSDate, String)] {
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
    private func pickUpDateFromNSArray(bustime: NSArray, station: String) -> [(NSDate, String)] {
        var bustimeDates: [(NSDate, String)] = []
        
        for item in bustime {
            let dateItem = self.setHourAndMinuteFromString(item as! String)
            bustimeDates.append((dateItem, station))
        }
        
        return bustimeDates
    }
    
    
    //文字列の時間をNSDate型にセットする
    private func setHourAndMinuteFromString(stringDate: String) -> NSDate {
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

    func formatFromNSDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(name: "GMT")
        formatter.dateFormat = "HH:mm"
        print("バス発車時刻\(date)")
        return formatter.stringFromDate(date)
    }
}
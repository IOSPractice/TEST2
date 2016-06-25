//
//  Bustime.swift
//  実習
//
//  Created by 大木一輝 on 2016/06/20.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit


public extension NSDate {
    //unitに指定されたNSDateのコンポーネントをdurationだけ前に戻す
    func before(unit: NSCalendarUnit, duration: Int) -> NSDate {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        var date = self
        let dateComps = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: self)
        dateComps.timeZone = NSTimeZone(name: "GTM")
        
        switch unit {
        case NSCalendarUnit.Year :
            dateComps.year -= duration
        case NSCalendarUnit.Month :
            dateComps.month  -= duration
        case NSCalendarUnit.Day :
            dateComps.day -= duration
        case NSCalendarUnit.Hour :
            dateComps.hour -= duration
        case NSCalendarUnit.Minute :
            dateComps.minute -= duration
        case NSCalendarUnit.Second :
            dateComps.second -= duration
        default:
            break
        }
        
        date = calendar.dateFromComponents(dateComps)!
        
        return date
    }
    
    //unitに指定されたNSDateのコンポーネントをdurationだけ進ませる
    func after(unit: NSCalendarUnit, duration: Int) -> NSDate {
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        var date = self
        let dateComps = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: self)
        dateComps.timeZone = NSTimeZone(name: "GTM")
        
        switch unit {
        case NSCalendarUnit.Year :
            dateComps.year += duration
        case NSCalendarUnit.Month :
            dateComps.month  += duration
        case NSCalendarUnit.Day :
            dateComps.day += duration
        case NSCalendarUnit.Hour :
            dateComps.hour += duration
        case NSCalendarUnit.Minute :
            dateComps.minute += duration
        case NSCalendarUnit.Second :
            dateComps.second += duration
        default:
            break
        }
        
        date = calendar.dateFromComponents(dateComps)!
        
        return date
    }
}


class Bustime: UIViewController {

    @IBOutlet weak var tableView: BustimeTableView!
    @IBOutlet weak var settingTableView: SettingTableView!
    
    var busDates: [(NSDate, String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        //ファイルからバスの時刻表データを取得する
        busDates = self.getBustimes()
        busDates.sortInPlace {$0.0.timeIntervalSince1970 < $1.0.timeIntervalSince1970}
        
        tableView.initialize(busDates)
        tableView.reloadData()
        settingTableView.initialize()
        settingTableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        return dateItems
    }
}

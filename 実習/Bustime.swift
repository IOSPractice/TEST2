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


class Bustime: UIViewController, UITableViewDataSource, UITableViewDelegate, PopUpPickerViewDelegate {

    @IBOutlet weak var tableView: BustimeTableView!     //バスの時刻表を表示するためのtableView
    @IBOutlet weak var settingTableView: UITableView!
    
    var datePicker: PopUpPickerView!
    
    var busDates: [(NSDate, String)] = []
    
    let sectionTitle: [String] = ["表示設定", "詳細設定"]
    let numberOfRowsInSections: [Int] = [2, 1]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //位置ズレの修正
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            self.edgesForExtendedLayout = .None
            self.extendedLayoutIncludesOpaqueBars = false
            self.automaticallyAdjustsScrollViewInsets = false
        }


        //ファイルからバスの時刻表データを取得する
        busDates = self.getBustimes()
        busDates.sortInPlace {$0.0.timeIntervalSince1970 < $1.0.timeIntervalSince1970}
        
        
        tableView.initialize(busDates)
        tableView.reloadData()
    
        
        //UIDatePickerの設定
        datePicker = PopUpPickerView()
        datePicker.delegate = self
        
        if let window = UIApplication.sharedApplication().keyWindow {
            window.addSubview(datePicker)
        } else {
            self.view.addSubview(datePicker)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        let viewController = self.navigationController?.viewControllers
        
        //DatePickerを表示したまま戻らないようにする処理
        if ((viewController?.contains(self)) != nil) {
            datePicker.hidePicker()
        }
    }
    
    
    //セクション数の設定
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitle.count
    }

    
    //セクションごとのセル数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    
    //セクションのタイトルを返す
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as String
    }


    //セクションの高さ設定
    func tableView(tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    
    //セル内の値設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CellSetting")
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "現在時刻"
            case 1:
                cell.textLabel?.text = "時刻を入力する"
            default:
                break
            }
            
        case 1:
            cell.textLabel?.text = "目的地設定"
        default:
            break
        }
        
        return cell
    }
    
    
    //セルの選択時のアクション
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {//表示設定の現在時刻が選択された時
                scrollToNowDate()
            } else if indexPath.row == 1 {
                datePicker.showPicker()
            }
        }
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
    
    
    //引数のNSDateを指定の書式にして文字列として返す
    func formatFromNSDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        formatter.timeZone = NSTimeZone(name: "GMT")
        formatter.dateFormat = "HH:mm"
        return formatter.stringFromDate(date)
    }

    
    //時刻表と現在時刻を比較し、現在時刻から最も近いバスの発着時刻にあたるセルをトップにスクロールで持ってくる
    func scrollToNowDate() {
        var nowDate = NSDate()//現在時刻の取得
        
        //時刻のタイムゾーンの指定
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComps: NSDateComponents = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: nowDate)
        dateComps.timeZone = NSTimeZone(name: "GMT")
        nowDate = calendar.dateFromComponents(dateComps)!

        //現在時刻に最も近いバス発着時刻の取得
        for (i, time) in busDates.enumerate() {
            if nowDate.compare(time.0) == NSComparisonResult.OrderedAscending {
                //スクロール用のNSIndexPathの作成
                let index = NSIndexPath(forRow: i, inSection: 0)
                self.tableView.scrollToRowAtIndexPath(index, atScrollPosition: .Top, animated: true)
                break
            }
        }
    }
    
    
    //指定された時刻に最も近いバス発着時刻のセルをトップにスクロールで持ってくる
    func scrollToSpecifiedDate(date: NSDate) {
        
        //現在時刻に最も近いバス発着時刻の取得
        for (i, time) in busDates.enumerate() {
            if date.compare(time.0) == NSComparisonResult.OrderedAscending {
                //スクロール用のNSIndexPathの作成
                let index = NSIndexPath(forRow: i, inSection: 0)
                self.tableView.scrollToRowAtIndexPath(index, atScrollPosition: .Top, animated: true)
                break
            }
        }

    }
    
    func pickerView(pickerView: UIDatePicker, didSelect date: NSDate?) {
        if date != nil {
            self.scrollToSpecifiedDate(date!)
        }
    }

}

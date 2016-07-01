//
//  File.swift
//  実習
//
//  Created by 大木一輝 on 2016/07/01.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class PopUpPickerView: UIView {
    var datePicker: UIDatePicker!
    var pickerToolbar: UIToolbar!
    var toolbarItems = [UIBarButtonItem]()
    
    var delegate: PopUpPickerViewDelegate?
    
    private var selectedDate: NSDate?
    
    //initializer
    init() {
        super.init(frame: CGRect.zero)
        initFunc()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFunc()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFunc()
    }
    
    private func initFunc() {
        let screenSize = UIScreen.mainScreen().bounds.size
        self.backgroundColor = UIColor.clearColor()
        
        pickerToolbar = UIToolbar()
        datePicker = UIDatePicker()
        
        pickerToolbar.translucent = true
        pickerToolbar.backgroundColor = UIColor.clearColor()
        
        datePicker.backgroundColor = UIColor.blackColor()
        datePicker.datePickerMode = .Time
        datePicker.backgroundColor = UIColor.whiteColor()
        datePicker.addTarget(self, action: #selector(PopUpPickerView.valuedChangedDate(_:)), forControlEvents: .ValueChanged)
        
        self.bounds = CGRectMake(0, 0, screenSize.width, 260)
        self.frame = CGRectMake(0, screenSize.height, screenSize.width, 260)
        pickerToolbar.bounds = CGRectMake(0, 0, screenSize.width, 44)
        pickerToolbar.frame = CGRectMake(0, 0, screenSize.width, 44)
        datePicker.bounds = CGRectMake(0, 0, screenSize.width, 216)
        datePicker.frame = CGRectMake(0, 44, screenSize.width, 216)
        
        let space = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        space.width = 12
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(PopUpPickerView.cancelPicker))
        let flexSpaceItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(PopUpPickerView.endPicker))
        toolbarItems = [cancelButton, flexSpaceItem, doneButton]
        
        pickerToolbar.setItems(toolbarItems, animated: true)
        self.addSubview(pickerToolbar)
        self.addSubview(datePicker)
    }

    func showPicker() {
        let screenSize = UIScreen.mainScreen().bounds.size
        UIView.animateWithDuration(0.2) {
            self.frame = CGRectMake(0, screenSize.height - 260, screenSize.width, 260.0)
        }
    }
    
    func cancelPicker() {
        hidePicker()
        selectedDate = nil
    }
    
    func endPicker() {
        hidePicker()
        delegate?.pickerView!(datePicker, didSelect: selectedDate)
        selectedDate = nil
    }
    
    private func hidePicker() {
        let screenSize = UIScreen.mainScreen().bounds.size
        
        UIView.animateWithDuration(0.2) {
            self.frame = CGRectMake(0, screenSize.height, screenSize.width, 260)
        }
    }
    
    func valuedChangedDate(sender: UIDatePicker) {
        let date = sender.date

        //タイムゾーンの変更
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let dateComps = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date)
        dateComps.timeZone = NSTimeZone(name: "GMT")
        
        self.selectedDate = calendar.dateFromComponents(dateComps)!
    }
}

@objc
protocol PopUpPickerViewDelegate: UIPickerViewDelegate {
    optional func pickerView(pickerView: UIDatePicker, didSelect date: NSDate?)
}
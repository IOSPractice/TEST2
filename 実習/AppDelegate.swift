//
//  AppDelegate.swift
//  実習
//
//  Created by 大木一輝 on 2016/05/13.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit
import MagicalRecord
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        /*初回起動の動作
          バスの表示駅一覧のデータをすべて表示可能な設定にしておく*/
        if(isFirstRun()) {
            let realm = try! Realm()
            let destSations = BusDestinationData()//登録したい駅情報
            
            //データの書き込み
            try! realm.write() {
                realm.add(destSations)
            }
            
            //バス通知の設定
            let busNnotification = NSUserDefaults.standardUserDefaults()
            busNnotification.setBool(false, forKey: "busNotification")
        }
        
        //アプリケーション起動時、バス通知の登録が許可されていれば登録する
        let busNotification = NSUserDefaults.standardUserDefaults()
        if busNotification.boolForKey("busNotification") {
            let notification = MyLocalNotification()
            notification.setNotificationBustimes()
        }
        
        MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed("TodoApp.sqlite")
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        MagicalRecord.cleanUp()
    }

    //初回起動判定関数
    func isFirstRun() -> Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if(defaults.boolForKey("firstRun")) {
            return false
        }
        defaults.setBool(false, forKey: "firstRun")
        
        return true
    }
}


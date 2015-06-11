//
//  AppDelegate.swift
//  GalaxyMarket
//
//  Created by Ozan Asan on 25/05/15.
//  Copyright (c) 2015 OzanAsan. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /*
    func registerForNotification() {
        
        let action1 = UIMutableUserNotificationAction()
        action1.activationMode = UIUserNotificationActivationMode.Background
        action1.title = "Action 1"
        action1.identifier = "ACTION_ONE"
        action1.destructive = false
        action1.authenticationRequired = false
        
        let action2 = UIMutableUserNotificationAction()
        action2.activationMode = UIUserNotificationActivationMode.Background
        action2.title = "Action 2"
        action2.identifier = "ACTION_TWO"
        action2.destructive = false
        action2.authenticationRequired = false
        
        
        let actionCategory = UIMutableUserNotificationCategory()
        actionCategory.identifier = "Action"
        actionCategory.setActions([action1, action2], forContext: UIUserNotificationActionContext.Default)
        
        let categories = NSSet(object: actionCategory)
        
        let types : UIUserNotificationType = (UIUserNotificationType.Alert | UIUserNotificationType.Badge)
        
        var settings = UIUserNotificationSettings(forTypes: types, categories: categories as Set<NSObject>)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    */
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if(UIApplication.instancesRespondToSelector("registerUserNotificationSettings:")) {
            
            //registerForNotification()
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Alert | UIUserNotificationType.Badge, categories: nil))
        }
        return true
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        println("Entering into background...")
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        println("didReceiveLocalNotification is called...")
    }
}


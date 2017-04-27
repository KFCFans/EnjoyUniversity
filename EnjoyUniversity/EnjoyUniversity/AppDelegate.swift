//
//  AppDelegate.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        /// 判断加载哪一个
        if let _ = UserDefaults.standard.string(forKey: "accesstoken"){
            window?.rootViewController = EUMainViewController()
        }else{
            window?.rootViewController = EUNavigationController(rootViewController: EULoginViewController())
        }
        window?.makeKeyAndVisible()
        
        // JPush
        let entiity = JPUSHRegisterEntity()
        entiity.types = Int(UNAuthorizationOptions.alert.rawValue |
            UNAuthorizationOptions.badge.rawValue |
            UNAuthorizationOptions.sound.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entiity, delegate: self)
        // 注册极光推送
        JPUSHService.setup(withOption: launchOptions, appKey: "7dd9d0f83f93c23e2c295dc0", channel:"App Store" , apsForProduction: false);

        return true
    }
    
    // 注册APNs成功并上报DeviceToken
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken)
        JPUSHService.registerDeviceToken(deviceToken)
    }
}

extension AppDelegate:JPUSHRegisterDelegate{
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        print(">JPUSHRegisterDelegate jpushNotificationCenter didReceive");
        let userInfo = response.notification.request.content.userInfo
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
        
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        print(">JPUSHRegisterDelegate jpushNotificationCenter willPresent");
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(UNAuthorizationOptions.alert.rawValue))// 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        
    }
    
}

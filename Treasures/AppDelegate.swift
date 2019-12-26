//
//  AppDelegate.swift
//  Treasures
//
//  Created by joanfen on 2019/12/4.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var launchView:UIView!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITabBar.appearance().tintColor = ColorConstants.globalMainColor
        DatabaseHandler.createTables()
        //        DatabaseHandler.insertData()
        if (!UserDefaults.init().bool(forKey: "notLaunched")) {
            DatabaseHandler.insertCategoriesData()
            UserDefaults.init().setValue(true, forKey: "notLaunched")
        }
        UserDefaults.standard.set(false, forKey: "showSplash")
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let pw = UserDefaults.standard.object(forKey: "password") as? String
        if pw == nil || pw!.isEmpty {
            let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            window?.rootViewController = rootVC
        }else {
            let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginController
            window?.rootViewController = rootVC
        }
        //根视图是登录页面
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    
}


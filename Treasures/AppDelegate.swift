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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UITabBar.appearance().tintColor = ColorConstants.globalMainColor
        DatabaseHandler.createTables()
        testInsert()
//        DatabaseHandler.insertData()
        if (!UserDefaults.init().bool(forKey: "notLaunched")) {
            DatabaseHandler.insertCategoriesData()
            UserDefaults.init().setValue(true, forKey: "notLaunched")
        }
        return true
    }

    func testInsert() {
        let treasure = TreasuresTable()
        treasure.name = "瓷瓶"
        treasure.year = "1445"
        treasure.firstCategoryId = 11
        treasure.secondCategoryId = 1
        treasure.description = "描述描述描述"
    
        treasure.purchasedPriceInCent = 10000000
        treasure.sellingPriceInCent = 2000000
        
        treasure.keywords = "材质, 好"
        treasure.available = true
        do {
            try DatabaseHandler.getMainDatabase().insert(objects: treasure, intoTable: DBConstants.treasuresTable)
        }
        catch let exception {
            print(exception)
        }
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


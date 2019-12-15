//
//  DatabaseCommonHandler.swift
//  Treasures
//
//  Created by joanfen on 2019/11/28.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import WCDBSwift

class DatabaseHandler {
    static func getMainDatabase() -> Database {
        return Database.init(withPath: path())
    }
    
    static func createTables() {
        let database = getMainDatabase()
        do {
            try database.create(table: DBConstants.treasuresTable, of: TreasuresTable.self)
            try database.create(table: DBConstants.firstCategoryTable, of: FirstCategoryTable.self)
            try database.create(table: DBConstants.secondCategoryTable, of: SecondCategoryTable.self)
        }
        catch let exception {
            print(exception)
        }
    }
    
    private static func path() -> String {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        let path =  (documentPaths.first ?? "") + DBConstants.dbSubPath
        print("数据库目录：" + path)
        print("\n")
        return path
    }
    
    static func insertCategoriesData() {
        prepareFirstCategoryData()
        prepareSecondCategoryData()
    }
    
    private static func prepareSecondCategoryData() {
       let categories = PathHandler.getSecondCategory()
       var objects = [SecondCategoryTable]()
       for dic in categories {
           objects.append(SecondCategoryTable.init(raw: dic))
       }
       do {
           try DatabaseHandler.getMainDatabase().insertOrReplace(objects: objects,
                                                        intoTable: DBConstants.secondCategoryTable)
       }
       catch let exception {
           print(exception)
       }
    }
    
    private static func prepareFirstCategoryData() {
        let firstCategories = PathHandler.getFirstCategory()
        var objects = [FirstCategoryTable]()
        for dic in firstCategories {
            objects.append(FirstCategoryTable.init(raw: dic))
        }
        do {
            try DatabaseHandler.getMainDatabase().insertOrReplace(objects: objects,
                                                         intoTable: DBConstants.firstCategoryTable)
        }
        catch let exception {
            print(exception)
        }
    }
    
    static func insertData() {
        let treasure = TreasuresTable()
        treasure.name = "瓷瓶"
        treasure.year = 1445
        treasure.firstCategoryId = 11
        treasure.secondCategoryId = 1
        treasure.description = "描述描述描述"
        treasure.urls = ["http://image.baidu.com/search/detail?ct=503316480&z=undefined&tn=baiduimagedetail&ipn=d&word=%E5%9B%BE%E7%89%87&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=undefined&hd=undefined&latest=undefined&copyright=undefined&cs=2394972844,3024358326&os=2815253048,2891632850&simid=3399081282,156411405&pn=11&rn=1&di=157630&ln=1719&fr=&fmq=1575791403526_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&is=0,0&istype=0&ist=&jit=&bdtype=0&spn=0&pi=0&gsm=0&objurl=http%3A%2F%2Ffile02.16sucai.com%2Fd%2Ffile%2F2015%2F0128%2F8b0f093a8edea9f7e7458406f19098af.jpg&rpstart=0&rpnum=0&adpicid=0&force=undefined"]
        treasure.purchasedPriceInCent = 10000000
        treasure.sellingPriceInCent = 2000000
        treasure.length = 100
        treasure.width = 100
        treasure.height = 20
        
        treasure.keywords = "材质, 好"
        treasure.volume = 200000
        treasure.available = true
        do {
            
            let statement = StatementInsert()
            statement.insert(intoTable: DBConstants.treasuresTable)
            let state = StatementSelect()
            state.select(distinct: false, TreasuresTable.Properties.identifier.max())
            
            try DatabaseHandler.getMainDatabase().insert(objects: treasure, intoTable: DBConstants.treasuresTable)
        }
        catch let exception {
            print(exception)
        }
    }
    
    
}

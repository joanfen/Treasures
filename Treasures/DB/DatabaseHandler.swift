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
            try database.create(table: DBConstants.keywordsTable, of: KeywordsTable.self)
        }
        catch let exception {
            print(exception)
        }
    }
    
    private static func path() -> String {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        let path =  (documentPaths.first ?? "") + DBConstants.dbSubPath
        print("数据库目录：\(path)\n")
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
        treasure.year = "1445"
        treasure.firstCategoryId = 11
        treasure.secondCategoryId = 1
        treasure.description = "描述描述描述"
        treasure.purchasedPriceInCent = 10000000
        treasure.sellingPriceInCent = 2000000
        
        treasure.keywords = "材质, 好"
        treasure.size = "200000"
        treasure.sellStatus = SellStatus.unavaliable.rawValue
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

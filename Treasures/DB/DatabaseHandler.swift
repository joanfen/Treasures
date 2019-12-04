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
        return path
    }
}

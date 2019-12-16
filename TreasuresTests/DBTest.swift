//
//  test.swift
//  TreasuresTests
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import XCTest
import WCDBSwift
import Treasures
class test: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    
    func testDB() {
        DatabaseHandler.createTables()
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
    
    
    
    func testFind() {
        do {
            let objects: [TreasuresTable] = try DatabaseHandler.getMainDatabase().getObjects( fromTable: DBConstants.treasuresTable)
            print(objects)
        } catch let exception {
            print(exception)
        }
        
    }
    
    func testConditionFind() {
        let filterPreference = FilterPreference()
        filterPreference.searchText = ""
        let objects: [TreasuresTable] = TreasureRepository().findTreasuresByCondition(condition: filterPreference.toQueryConditions(), orderBy: filterPreference.toOrderBy())
        print(objects)
   
    }

    func testPrepareData() {
        DatabaseHandler.insertCategoriesData()
    }
    func testMaxId() {
        TreasureRepository.getMaxID()
    }
    
    func testFirstCategory() {
        CategoryRepo().queryFirstCategories()
        
    }
    func testSecondCategory() {
        CategoryRepo().querySecondCategories(parentId: 1)
    }
    
    func testQuery () {
        CategoryRepo().queryMyCategories()
    }
}

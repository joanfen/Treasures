//
//  test.swift
//  TreasuresTests
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import XCTest
import WCDBSwift
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
        do {
            try DatabaseHandler.getMainDatabase().insert(objects: treasure, intoTable: DBConstants.treasuresTable)
        }
        catch let exception {
            print(exception)
        }
    }
    
    
    
    func testCollected() {
        TreasureRepository.collectTreasureBy(id: 1)
        let treasure = TreasureRepository.findCollectedTreasures()
        print(treasure.count)
        
    }
    
    func testPrepareData() {
        DatabaseHandler.insertCategoriesData()
    }
    func testMaxId() {
        TreasureRepository.getMaxID()
    }
    
    func testFirstCategory() {
        CategoryRepo.queryFirstCategories()
        
    }
    func testSecondCategory() {
        CategoryRepo.querySecondCategories(parentId: 11)
    }
    
    func testQuery () {
        CategoryRepo.enableCategory(secondCategoryId: 1)
        CategoryRepo.enableCategory(secondCategoryId: 3)
        CategoryRepo.enableCategory(secondCategoryId: 20)

        CategoryRepo.queryMyCategories()
    }
    
    
    func testThumbnailSave() {
        PathHandler.saveThumbnail(image: UIImage())
    }
    
    func testData() {
        let count = TreasureRepository.getDataStatistic()
        print(count)
    }
}

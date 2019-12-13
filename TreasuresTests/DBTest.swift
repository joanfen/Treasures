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
        treasure.year = 1445
        treasure.firstCategoryId = 11
        treasure.secondCategoryId = 1
        treasure.description = "描述描述描述"
        treasure.urls = ["http://image.baidu.com/search/detail?ct=503316480&z=undefined&tn=baiduimagedetail&ipn=d&word=%E5%9B%BE%E7%89%87&step_word=&ie=utf-8&in=&cl=2&lm=-1&st=undefined&hd=undefined&latest=undefined&copyright=undefined&cs=2394972844,3024358326&os=2815253048,2891632850&simid=3399081282,156411405&pn=11&rn=1&di=157630&ln=1719&fr=&fmq=1575791403526_R&fm=&ic=undefined&s=undefined&se=&sme=&tab=0&width=undefined&height=undefined&face=undefined&is=0,0&istype=0&ist=&jit=&bdtype=0&spn=0&pi=0&gsm=0&objurl=http%3A%2F%2Ffile02.16sucai.com%2Fd%2Ffile%2F2015%2F0128%2F8b0f093a8edea9f7e7458406f19098af.jpg&rpstart=0&rpnum=0&adpicid=0&force=undefined"]
        treasure.purchasingPriceInCent = 10000000
        treasure.sellingPriceInCent = 2000000
        treasure.length = 100
        treasure.width = 100
        treasure.height = 20
        
        treasure.keywords = "材质, 好"
        treasure.volume = 200000
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
    func testMultiFind() {
        let filterPreference = FilterPreference()
        filterPreference.searchText = ""
        TreasureRepository().findTreasures(properties: filterPreference.toProperties(), condition: filterPreference.toQueryConditions(), orderBy: filterPreference.toOrderBy())
        
    }
    func testPrepareData() {
        DatabaseHandler.insertCategoriesData()
    }
}

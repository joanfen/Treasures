//
//  TreasuresTests.swift
//  TreasuresTests
//
//  Created by joanfen on 2019/12/4.
//  Copyright © 2019 joanfen. All rights reserved.
//

import XCTest
import SwiftyJSON

class TreasuresTests: XCTestCase {

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
    
    func testEncode() {
        print("\n----- 测试加密解密 Start ------\n")
        
        let origin = 201912211
        print("原始值: \(origin)")
        
        let result = InviteCodeUtils.encode(by: origin)
        print("加密后: \(result)")
        
        let code = InviteCodeUtils.decode(by: result)
        print("解密后: \(code)")
        
        print("\n----- 测试加密解密 End ------\n")
        
    }
}

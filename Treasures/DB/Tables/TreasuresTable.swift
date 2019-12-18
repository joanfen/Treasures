//
//  TreasuresTable.swift
//  Treasures
//
//  Created by joanfen on 2019/11/23.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import WCDBSwift
class TreasuresTable: TableCodable {
    var identifier: Int? = nil
    var name: String = ""
    var firstCategoryId: Int = 0
    var secondCategoryId: Int = 0
    var description: String = ""
    var year: String = ""
    var purchasedYear: Int = 0
    var purchasedPriceInCent: Int64 = 0
    var sellingPriceInCent: Int64 =  0
    var available: Bool = false
    var isSold: Bool = false
    var size: String = ""
    var keywords: String = ""
    var note: String = ""
    var isCollected: Bool = false
    var deleted: Bool = false
    var created: Date = Date()

    
    enum CodingKeys: String, CodingTableKey {
        
        typealias Root = TreasuresTable
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case identifier = "id"
        case name
        case firstCategoryId
        case secondCategoryId
        case description
        case year
        case purchasedYear
        case purchasedPriceInCent
        case sellingPriceInCent
        case available
        case isSold
        case size
        case keywords
        case note
        case isCollected
        case deleted
        case created
        
        
        static var columnConstraintBindings: [TreasuresTable.CodingKeys : ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
                created: ColumnConstraintBinding(isNotNull: true, defaultTo: Date())
            ]
        }
    }
}


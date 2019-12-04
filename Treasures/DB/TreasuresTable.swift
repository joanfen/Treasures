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
    var identifier: Int = 0
    var name: String = ""
    var firstCategoryId: Int = 0
    var secondCategoryId: Int = 0
    var description: String = ""
    var urls: Array = [""]
    var year: Int = 0
    var purchasingPriceInCent: Int64 = 0
    var sellingPriceInCent: Int64 =  0
    var available: Bool = false
    var isSold: Bool = false
    var length: Int64 = 0
    var width: Int64 = 0
    var height: Int64 = 0
    var volume: CLong = 0
    var keywords: String = ""
    var note: String = ""
    var created: Date = Date()

    
    enum CodingKeys: String, CodingTableKey {
        
        typealias Root = TreasuresTable
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case identifier = "id"
        case name
        case firstCategoryId
        case secondCategoryId
        case description
        case urls
        case year
        case purchasingPriceInCent
        case sellingPriceInCent
        case available
        case isSold
        case length
        case width
        case height
        case volume
        case keywords
        case note
        case created
        
        
        static var columnConstraintBindings: [TreasuresTable.CodingKeys : ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
                created: ColumnConstraintBinding(isNotNull: true, defaultTo: Date())
            ]
        }
        
        
    }
}

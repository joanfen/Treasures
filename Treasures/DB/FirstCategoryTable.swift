//
//  FirstCategoryTable.swift
//  Treasures
//
//  Created by joanfen on 2019/11/28.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import WCDBSwift
class FirstCategoryTable: TableCodable {
    var identifier: Int = 0
    var name: String = ""
    var created: Date = Date()

    enum CodingKeys: String, CodingTableKey {
        
        typealias Root = FirstCategoryTable
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case identifier = "id"
        case name
        case created
        
        
        static var columnConstraintBindings: [FirstCategoryTable.CodingKeys : ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
                created: ColumnConstraintBinding(isNotNull: true, defaultTo: Date())
            ]
        }
        
        
    }
}

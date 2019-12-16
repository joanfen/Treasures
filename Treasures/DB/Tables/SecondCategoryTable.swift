//
//  SecondCategoryTable.swift
//  Treasures
//
//  Created by joanfen on 2019/11/28.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import WCDBSwift
class SecondCategoryTable: TableCodable {
    var identifier: Int? = nil
    var parentCategoryId: Int? = 0
    var name: String? = ""
    var enable: Bool = false
    var created: Date = Date()

    enum CodingKeys: String, CodingTableKey {
        
        typealias Root = SecondCategoryTable
        
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
        case identifier = "id"
        case parentCategoryId
        case name
        case enable
        case created
        
        static var columnConstraintBindings: [SecondCategoryTable.CodingKeys : ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
                created: ColumnConstraintBinding(isNotNull: true, defaultTo: Date())
            ]
        }
    }
    init(raw: [String: Any]) {
        self.parentCategoryId = raw["parentCategoryId"] as? Int
        self.name = raw["name"] as? String
    }
    
    init() {
        
    }
}

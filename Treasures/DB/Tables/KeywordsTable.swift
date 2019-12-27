//
//  Keywords.swift
//  Treasures
//
//  Created by joanfen on 2019/12/27.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit
import WCDBSwift
class KeywordsTable: TableCodable {
    var identifier: Int? = nil
    var name: String? = ""
    var created: Date = Date()

    enum CodingKeys: String, CodingTableKey {
        
    typealias Root = KeywordsTable
        
    static let objectRelationalMapping = TableBinding(CodingKeys.self)
        
    case identifier = "id"
    case name
    case created
           
    static var columnConstraintBindings: [KeywordsTable.CodingKeys : ColumnConstraintBinding]? {
        return [
            identifier: ColumnConstraintBinding(isPrimary: true, isAutoIncrement: true),
            name: ColumnConstraintBinding(isUnique: true),
            created: ColumnConstraintBinding(isNotNull: true, defaultTo: Date())
            ]
        }
       
    }
}

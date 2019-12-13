//
//  DBConstants.swift
//  Treasures
//
//  Created by joanfen on 2019/11/28.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import WCDBSwift
struct DBConstants {
    static let dbSubPath = "/treasures.db"
    static let treasuresTable = "treasuresTable"
    static let firstCategoryTable = "firstCategoryTable"
    static let secondCategoryTable = "secondCategoryTable"
    static let invitorsTable = "invitorsTable"
    
    static var treasureProperties: [PropertyConvertible] {
        var list: [PropertyConvertible] = TreasuresTable.Properties.all
        list.remove(at: 0) // remove identifier 有重复对象，需要 remove掉，在后面指定其是哪个 table 里的字段
        list.remove(at: 0) // remove name 有重复对象
        list.removeLast()
        list.append(TreasuresTable.Properties.created.in(table: DBConstants.treasuresTable))
        list.append(TreasuresTable.Properties.name.in(table: DBConstants.treasuresTable))
        list.append(TreasuresTable.Properties.identifier.in(table: DBConstants.treasuresTable))
        return list;
    }
    static var firstCategoryProperties: [PropertyConvertible] {
        return [SecondCategoryTable.Properties.identifier.in(table: DBConstants.secondCategoryTable),
        SecondCategoryTable.Properties.parentCategoryId.in(table: DBConstants.secondCategoryTable),
        SecondCategoryTable.Properties.name.in(table: DBConstants.secondCategoryTable),
        SecondCategoryTable.Properties.created.in(table: DBConstants.secondCategoryTable)]
    }
    static var secondCategoryProperties: [PropertyConvertible] {
        return [FirstCategoryTable.Properties.identifier.in(table: DBConstants.firstCategoryTable),
        FirstCategoryTable.Properties.name.in(table: DBConstants.firstCategoryTable),
        FirstCategoryTable.Properties.created.in(table: DBConstants.firstCategoryTable)]
    }
}

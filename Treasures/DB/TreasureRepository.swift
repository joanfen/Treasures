//
//  TreasureRepository.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import WCDBSwift

class TreasureRepository {
    func findTreasuresByCondition(condition: Condition, orderBy: [OrderBy]) -> [TreasuresTable] {
        do {
            let objects: [TreasuresTable] = try DatabaseHandler.getMainDatabase().prepareSelect(of: TreasuresTable.self, fromTable: DBConstants.treasuresTable).where(condition).order(by: orderBy).allObjects()
            return objects
        }
        catch let exception {
            print(exception)
        }
        return []
    }
    
    func findTreasures(query: Queryable) -> [TreasureSearchDTO] {
        var treasures = [TreasureSearchDTO]()
        do {
            let multiSelect = try DatabaseHandler.getMainDatabase().prepareMultiSelect(
                    on: query.toProperties(),
                    fromTables: [DBConstants.treasuresTable, DBConstants.secondCategoryTable])
                .where(query.toQueryConditions())
                .order(by: query.toOrderBy())
                .limit(from: query.page()*query.size(),
                       to: query.size())
            while let multiObject = try multiSelect.nextMultiObject() {
                let treasure = multiObject[DBConstants.treasuresTable] as? TreasuresTable
                let category = multiObject[DBConstants.secondCategoryTable] as? SecondCategoryTable
                if let object = treasure {
                    treasures.append(TreasureSearchDTO.init(with: object, categoryName: category?.name))
                }
            }
            return treasures
        }
        catch let exception {
            print(exception)
        }
        return treasures
    }
    
}

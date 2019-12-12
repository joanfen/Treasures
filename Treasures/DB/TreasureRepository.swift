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
            let objects: [TreasuresTable] = try DatabaseHandler.getMainDatabase().getObjects(on: TreasuresTable.Properties.all, fromTable: DBConstants.treasuresTable)
            
//            let objects: [TreasuresTable] = try DatabaseHandler.getMainDatabase().prepareSelect(of: TreasuresTable.self, fromTable: DBConstants.treasuresTable).order(by: orderBy).where(condition).allObjects()
            return objects
        }
        catch let exception {
            print(exception)
        }
        return []
    }
}

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
    
    /**
     * 分页查询藏品数据--首页数据
     */
    func findTreasures(query: Queryable) -> [TreasureListSearchDTO] {
        var treasures = [TreasureListSearchDTO]()
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
                    treasures.append(TreasureListSearchDTO.init(with: object, categoryName: category?.name))
                }
            }
            return treasures
        }
        catch let exception {
            print(exception)
        }
        return treasures
    }
    
    func findTreasureDetailWith(id: Int) -> TreasureDetailDTO {
        let dto = TreasureDetailDTO()
        do {
            var properties = DBConstants.treasureProperties
            properties.append(contentsOf: DBConstants.firstCategoryProperties)
            properties.append(contentsOf: DBConstants.secondCategoryProperties)
            
            let multiSelect = try DatabaseHandler.getMainDatabase().prepareMultiSelect(
                on: properties,
                fromTables: [DBConstants.treasuresTable,
                             DBConstants.firstCategoryTable,
                             DBConstants.secondCategoryTable])
                .where(TreasuresTable.Properties.firstCategoryId == FirstCategoryTable.Properties.identifier.in(table: DBConstants.firstCategoryTable)
                    && TreasuresTable.Properties.secondCategoryId == SecondCategoryTable.Properties.identifier.in(table: DBConstants.secondCategoryTable))
            while let multiObject = try multiSelect.nextMultiObject() {
                let treasure = multiObject[DBConstants.treasuresTable] as? TreasuresTable
                let first = multiObject[DBConstants.firstCategoryTable] as? FirstCategoryTable
                let second = multiObject[DBConstants.secondCategoryTable] as? SecondCategoryTable
                dto.treasureTable = treasure ?? TreasuresTable()
                dto.firstCategoryName = first?.name ?? ""
                dto.secondCategoryName = second?.name ?? ""
                return dto
            }
            
            
        } catch let ex {
            print(ex)
        }
        return dto
    }
    
}

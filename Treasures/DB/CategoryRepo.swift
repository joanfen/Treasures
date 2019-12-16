//
//  FirstCategoryRepo.swift
//  Treasures
//
//  Created by joanfen on 2019/12/13.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import WCDBSwift
class CategoryRepo {
    public func queryFirstCategories() -> [FirstCategoryTable] {
        do {
            let objects: [FirstCategoryTable] = try DatabaseHandler.getMainDatabase().getObjects(on: FirstCategoryTable.Properties.all, fromTable: DBConstants.firstCategoryTable)
            return objects
            
            
        } catch _ {
            
        }
        return []
    }
    public func querySecondCategories(parentId: Int) -> [SecondCategoryTable] {
        let table = DBConstants.secondCategoryTable
        do {
            let objects: [SecondCategoryTable] = try DatabaseHandler.getMainDatabase().getObjects(on: SecondCategoryTable.Properties.all, fromTable: table, where: SecondCategoryTable.Properties.parentCategoryId == parentId, orderBy: nil, limit: nil, offset: nil)
            return objects
        
        } catch _ {
            
        }
        return []
    }
    
    public func queryMyCategories() {
        var properties = DBConstants.firstCategoryProperties
        properties.append(contentsOf: DBConstants.secondCategoryProperties)
        let first = DBConstants.firstCategoryTable
        let second = DBConstants.secondCategoryTable
            do {
                let multiSelect = try DatabaseHandler.getMainDatabase().prepareMultiSelect(
                        on: properties,
                        fromTables: [first, second])
                    .where(FirstCategoryTable.Properties.identifier.in(table: first) == SecondCategoryTable.Properties.parentCategoryId.in(table: second))
                    .order(by: [])
                while let multiObject = try multiSelect.nextMultiObject() {
                    let firstCategory = multiObject[first] as? FirstCategoryTable
                    let secondCategory = multiObject[second] as? [SecondCategoryTable]
                    
                }
               
            }
            catch let exception {
                print(exception)
            }
        }
    }
}

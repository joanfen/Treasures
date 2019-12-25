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
    /**
     * 查询所有一级类目
     */
    class public func queryFirstCategories() -> [FirstCategoryTable] {
        do {
            let objects: [FirstCategoryTable] = try DatabaseHandler.getMainDatabase().getObjects(on: FirstCategoryTable.Properties.all, fromTable: DBConstants.firstCategoryTable)
            return objects
            
            
        } catch _ {
            
        }
        return []
    }
    
    /**
     * 查询一级类目下面的所有二级类目
     */
    class public func querySecondCategories(parentId: Int) -> [SecondCategoryVO] {
        let table = DBConstants.secondCategoryTable
        var secondCategoryList = [SecondCategoryVO]()

        do {
            let objects: [SecondCategoryTable] = try DatabaseHandler.getMainDatabase().getObjects(on: SecondCategoryTable.Properties.all, fromTable: table, where: SecondCategoryTable.Properties.parentCategoryId == parentId, orderBy: nil, limit: nil, offset: nil)
            
            let map = getCountByParentId(parentId: parentId)
            for table in objects {
                let second = SecondCategoryVO()
                second.identifier = table.identifier
                second.parentCategoryId = table.parentCategoryId
                second.name = table.name
                second.created = table.created
                
                if let id = table.identifier {
                    second.count = map[id] ?? 0
                }
                secondCategoryList.append(second)
            }
        
        } catch _ {
            
        }
        return secondCategoryList
    }
 
    class public func getCountByParentId(parentId: Int) -> [Int: Int] {
        var map = [Int: Int]()
        do {
            let secondCategoryId = TreasuresTable.CodingKeys.secondCategoryId.in(table: DBConstants.treasuresTable)
            
            let property: [ColumnResultConvertible] = [secondCategoryId,  TreasuresTable.Properties.identifier.in(table: DBConstants.treasuresTable).count()]
            
            let statement = StatementSelect().select(property)
                .from(DBConstants.treasuresTable)
                .where(TreasuresTable.Properties.firstCategoryId == parentId)
                .group(by: secondCategoryId)
            
            
            
            let coreStatement = try DatabaseHandler.getMainDatabase().prepare(statement)
            
            while try coreStatement.step() {
                let secondCategoryId: Int = coreStatement.value(atIndex: 0) ?? 0
                let count: Int = coreStatement.value(atIndex: 1) ?? 0
                map[secondCategoryId] = count
                
            }
        } catch let ex {
            print(ex)
        }
        return map
        
    }
    
    /**
     * 启用类目
     */
    class public func enableCategory(secondCategoryId: Int) -> Bool {
        return updateEnabled(categoryId: secondCategoryId, enable: true)
    }
    
    /**
     * 禁用类目
     */
    class public func disableCategory(secondCategoryId: Int) -> Bool {
        return updateEnabled(categoryId: secondCategoryId, enable: false)
    }
    
    
    class internal func updateEnabled(categoryId: Int, enable: Bool) -> Bool {
        let category = SecondCategoryTable()
        category.enable = enable
        do {
            try DatabaseHandler.getMainDatabase()
                .update(table: DBConstants.secondCategoryTable,
                        on: SecondCategoryTable.Properties.enable,
                        with: category,
                        where: SecondCategoryTable.Properties.identifier == categoryId)
            
            return true
        } catch let ex {
            print("更新类目启用状态失败: ")
            print(ex)
        }
        return false
    }
    
    /**
     * 查询所有已启用的类目
     */
    class public func queryMyCategories() -> [CategoryDTO] {
        var properties = DBConstants.firstCategoryProperties
        properties.append(contentsOf: DBConstants.secondCategoryProperties)
        let first = DBConstants.firstCategoryTable
        let second = DBConstants.secondCategoryTable
       
        var categories = [CategoryDTO]()
        
        do {
            let secondCategories: [SecondCategoryTable] = try DatabaseHandler.getMainDatabase().getObjects(on: SecondCategoryTable.Properties.all, fromTable: second, where: SecondCategoryTable.Properties.enable, orderBy: nil, limit: nil, offset: nil)
            let parents = secondCategories.map { (secondTableObject) -> Int in
                return (secondTableObject.parentCategoryId ?? 0)
            }
            let firstCategories: [FirstCategoryTable] = try DatabaseHandler.getMainDatabase().getObjects(on: FirstCategoryTable.Properties.all, fromTable: first, where: FirstCategoryTable.Properties.identifier.in(parents), orderBy: nil, limit: nil, offset: nil)

            for firstObject in firstCategories {
                let secondObjects = secondCategories.filter { (s) -> Bool in
                    s.parentCategoryId == firstObject.identifier
                }
                categories.append(CategoryDTO.init(first: firstObject,
                                                   second: secondObjects))
            }
            
        } catch _ {
            
        }
        
        return categories
    }
}




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
    class public func querySecondCategories(parentId: Int) -> [SecondCategoryTable] {
        let table = DBConstants.secondCategoryTable
        do {
            let objects: [SecondCategoryTable] = try DatabaseHandler.getMainDatabase().getObjects(on: SecondCategoryTable.Properties.all, fromTable: table, where: SecondCategoryTable.Properties.parentCategoryId == parentId, orderBy: nil, limit: nil, offset: nil)
            return objects
        
        } catch _ {
            
        }
        return []
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




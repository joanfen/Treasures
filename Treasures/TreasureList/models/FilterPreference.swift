//
//  FilterPreference.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import WCDBSwift

struct CategoryInfo {
    var id: Int
    var name: String
}

struct Category {
    var firstCategory: CategoryInfo
    var secondCategory: CategoryInfo
}

class FilterPreference: Queryable {
    var searchText: String? {
        didSet{
            currentPage = 0
        }
    }
    var yearOrderRule: OrderRule = OrderRule.none {
        didSet{
            currentPage = 0
        }
    }
    var sizeOrderRule: OrderRule = OrderRule.none {
        didSet{
            currentPage = 0
        }
    }
    var priceOrderRule: OrderRule = OrderRule.none {
        didSet{
            currentPage = 0
        }
    }
   
    var category: Category? {
        didSet{
            currentPage = 0
        }
    }
    var filterAvaliable: Bool = false {
        didSet{
            currentPage = 0
        }
    }
    var filterUnavaliable: Bool = false {
        didSet{
            currentPage = 0
        }
    }
    var filterSold: Bool = false {
        didSet{
            currentPage = 0
        }
    }

    var currentPage: Int = 0
    var limit: Int = 20
   
    func page() -> Int {
        return currentPage
    }
    
    func size() -> Int {
        return limit
    }
    
    func toProperties() -> [PropertyConvertible] {
        var list: [PropertyConvertible] = TreasuresTable.Properties.all
        list.remove(at: 0) // remove identifier 有重复对象，需要 remove掉，在后面指定其是哪个 table 里的字段
        list.remove(at: 0) // remove name 有重复对象
        list.removeLast()
        list.append(TreasuresTable.Properties.created.in(table: DBConstants.treasuresTable))
        list.append(TreasuresTable.Properties.name.in(table: DBConstants.treasuresTable))
        list.append(TreasuresTable.Properties.identifier.in(table: DBConstants.treasuresTable))
        list.append(SecondCategoryTable.Properties.name.in(table: DBConstants.secondCategoryTable))
        return list;
    }
    
    func toQueryConditions() -> Condition {
       
        let categoryId =  TreasuresTable.Properties.secondCategoryId.in(table: DBConstants.treasuresTable)
        let second = SecondCategoryTable.Properties.identifier.in(table: DBConstants.secondCategoryTable)
        var condition = categoryId == second
        
        if let c = category {
            condition = condition + TreasuresTable.Properties.firstCategoryId == c.firstCategory.id
            condition = condition + TreasuresTable.Properties.secondCategoryId == c.secondCategory.id
        }

        if let text = searchText?.trimmingCharacters(in: CharacterSet.whitespaces) {
            if (text.count > 0) {
                condition = condition + (TreasuresTable.Properties.name.like(text)
                || TreasuresTable.Properties.keywords.like(text)
                || TreasuresTable.Properties.description.like(text))
            }
        }
        if filterAvaliable {
            condition = condition + TreasuresTable.Properties.available
        }
        if filterUnavaliable {
            condition = condition + TreasuresTable.Properties.available == false
        }
        if filterSold {
            condition = condition + TreasuresTable.Properties.isSold
        }
        return condition
    }
    
    func toOrderBy() -> [OrderBy] {
        var orderBy = [OrderBy]()
        if let yearOrder = yearOrderRule.toOrderTerm() {
            orderBy.append(TreasuresTable.Properties.year.asOrder(by: yearOrder))

        }
        if let sizeOrder = sizeOrderRule.toOrderTerm() {
            orderBy.append(TreasuresTable.Properties.volume.asOrder(by: sizeOrder))
        }
        if let priceOrder = priceOrderRule.toOrderTerm() {
            orderBy.append(TreasuresTable.Properties.sellingPriceInCent.asOrder(by: priceOrder))
        }
        return orderBy
        
    }
    
   
    
}

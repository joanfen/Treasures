//
//  FilterPreference.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import WCDBSwift

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
    
    var filterDeleted: Bool? {
        didSet{
            currentPage = 0
        }
    }
    
    var filterCollected: Bool? {
        didSet {
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
        var list: [PropertyConvertible] = DBConstants.treasureProperties
    
        list.append(contentsOf: DBConstants.secondCategoryProperties)

        return list;
    }
    
    func toQueryConditions() -> Condition {
       
        let categoryId = TreasuresTable.Properties.secondCategoryId.in(table: DBConstants.treasuresTable)
        let second = SecondCategoryTable.Properties.identifier.in(table: DBConstants.secondCategoryTable)
        var condition = categoryId == second
        
        if let c = category {
            condition = condition && (TreasuresTable.Properties.secondCategoryId == c.secondCategory.id)
        }

        if let text = searchText?.trimmingCharacters(in: CharacterSet.whitespaces) {
            if (text.count > 0) {
                condition = condition && (TreasuresTable.Properties.name.like(text)
                || TreasuresTable.Properties.description.like(text))
            }
        }
        if filterAvaliable {
            condition = condition && (TreasuresTable.Properties.available)
        }
        if filterUnavaliable {
            condition = condition && (TreasuresTable.Properties.available == false)
        }
        if filterSold {
            condition = condition && (TreasuresTable.Properties.isSold)
        }
        
        if let collected = filterCollected {
            condition = condition && (TreasuresTable.Properties.isCollected == collected)
        }
        
        if let deleted = filterDeleted {
            condition = condition && (TreasuresTable.Properties.deleted == deleted)
        }
        
        return condition
    }
    
    func toOrderBy() -> [OrderBy] {
        var orderBy = [OrderBy]()
        if let yearOrder = yearOrderRule.toOrderTerm() {
            orderBy.append(TreasuresTable.Properties.year.asOrder(by: yearOrder))

        }
        if let sizeOrder = sizeOrderRule.toOrderTerm() {
            orderBy.append(TreasuresTable.Properties.size.asOrder(by: sizeOrder))
        }
        if let priceOrder = priceOrderRule.toOrderTerm() {
            orderBy.append(TreasuresTable.Properties.sellingPriceInCent.asOrder(by: priceOrder))
        }
        return orderBy
        
    }
    
   
    
}

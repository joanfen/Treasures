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
    func toQueryProperties() -> Condition {
       
        var condition = TreasuresTable.Properties.identifier.isNotNull()
        
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
    
    var searchText: String?
    var yearOrderRule: OrderRule = OrderRule.none
    var sizeOrderRule: OrderRule = OrderRule.none
    var priceOrderRule: OrderRule = OrderRule.none
    
    var category: Category?
    var filterAvaliable: Bool = false
    var filterUnavaliable: Bool = false
    var filterSold: Bool = false
    
    
}

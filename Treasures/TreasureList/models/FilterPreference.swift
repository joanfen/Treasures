//
//  FilterPreference.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation

struct CategoryInfo {
    var categoryId: Int
    var categoryName: String
}

struct Category {
    var firstCategory: CategoryInfo
    var secondCategory: CategoryInfo
}

class FilterPreference {

    
    
    var yearOrderRule: OrderRule = OrderRule.none
    var sizeOrderRule: OrderRule = OrderRule.none
    var priceOrderRule: OrderRule = OrderRule.none
    
    var category: Category?
    var filterAvaliable: Bool = false
    var filterUnavaliable: Bool = false
    var filterSold: Bool = false
    
    
}

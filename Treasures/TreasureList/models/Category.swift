//
//  Category.swift
//  Treasures
//
//  Created by joanfen on 2019/12/13.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
struct CategoryInfo {
    var id: Int
    var name: String
}

struct Category {
    var firstCategory: CategoryInfo
    var secondCategory: CategoryInfo
    
    func getName() -> String {
        return secondCategory.name
    }
}

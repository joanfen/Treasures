//
//  CategoryDTO.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/16.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation

class CategoryDTO {
    var firstId: Int = 0
    var name: String = ""
    var secondCategories = [SecondCategoryDTO]()
    
    init(first: FirstCategoryTable?, second: [SecondCategoryTable]) {
        self.firstId = first?.identifier ?? 0
        self.name = first?.name ?? ""
        self.secondCategories = second.map { (t) -> SecondCategoryDTO in
            return SecondCategoryDTO.init(second: t)
        }
    }

}

class SecondCategoryDTO {
    var secondId: Int = 0
    var parentId: Int = 0
    var name: String = ""
    var enable: Bool = false
    
    init(second: SecondCategoryTable) {
        self.secondId = second.identifier ?? 0
        self.parentId = second.parentCategoryId ?? 0
        self.name = second.name ?? ""
        self.enable = second.enable ?? false
    }
}

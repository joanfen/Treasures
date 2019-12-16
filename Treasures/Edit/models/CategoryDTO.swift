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
    
//    init(first: Fir)
}

class SecondCategoryDTO {
    var secondId: Int = 0
    var parentId: Int = 0
    var name: String = ""
    var enable: Bool = false
}

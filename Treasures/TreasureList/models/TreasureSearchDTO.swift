//
//  TreasureSearchDTO.swift
//  Treasures
//
//  Created by joanfen on 2019/12/13.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
class TreasureSearchDTO {
    var identifier: Int?
    var name: String = ""
    var imageUrl: String?
    var categoryName: String = ""
    var description: String
    var keywords: [String]
    var available: Bool = false
    var isCollected: Bool = false
    var created: Date
    
    init(with treasure: TreasuresTable, categoryName: String?) {
        self.identifier = treasure.identifier
        self.name = treasure.name
        self.imageUrl = treasure.urls.first
        self.categoryName = categoryName ?? ""
        self.description = treasure.description
        self.keywords = treasure.keywords.components(separatedBy: ",")
        self.available = treasure.available
        self.isCollected = treasure.isCollected
        self.created = treasure.created
    }
}

//
//  TreasureSearchHandler.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit
import Foundation
import WCDBSwift

class TreasureCellVO {
    var image: UIImage = UIImage()
    var title: String = String()
    var description: String = String()
    var keywords: [String] = []
    var isCollected: Bool = false
    var created: Date = Date()
    
    init(with treasure: TreasuresTable) {
        if let url = treasure.urls.first  {
            self.image = PathHandler.getImage(of: treasure.identifier, imgName: url) ?? UIImage()
        }
        self.title = treasure.name
        self.description = treasure.description
        self.keywords = treasure.description.components(separatedBy: ",")
        self.created = treasure.created
        
    }
}

class TreasureSearchHandler {
    
    var treasureRepo = TreasureRepository()
    
    func search(filter: FilterPreference) -> [TreasureCellVO] {
        let objects = treasureRepo.findTreasuresByCondition(condition: filter.toQueryProperties(), orderBy: filter.toOrderBy())
        var list = [TreasureCellVO]()
        objects.forEach { treasureTable in
            list.append(TreasureCellVO.init(with: treasureTable))
        }
        return list
    }
    
}

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
    var id: Int = 0
    var image: UIImage = UIImage()
    var title: String = String()
    var description: String = String()
    var keywords: [String] = []
    var isCollected: Bool = false
    var isAvaliable: Bool = false
    var secondCategoryName: String = ""
    var createdTimeStr: String = String()
    
    init(with treasure: TreasureListSearchDTO) {
        self.id = treasure.identifier ?? 0
        self.image = PathHandler.getImages(of: treasure.identifier).first ?? UIImage()
        self.title = treasure.name
        self.description = treasure.description
        self.keywords = treasure.keywords
        self.secondCategoryName = treasure.categoryName
        self.createdTimeStr = toDateTimeString(by: treasure.created)
    }
    
    private func toDateTimeString(by date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.MM.dd HH:mm:ss"
        return "添加于" + formatter.string(from: date)
    }
}

class TreasureSearchHandler {
    
    func search(filter: FilterPreference) -> [TreasureCellVO] {
        let objects = TreasureRepository.findTreasures(query: filter)
        var list = [TreasureCellVO]()
        objects.forEach { treasureTable in
            list.append(TreasureCellVO.init(with: treasureTable))
        }
        return list
    }
    
}

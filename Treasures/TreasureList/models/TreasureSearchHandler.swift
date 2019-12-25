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
    var image: UIImage?
    var title: String = String()
    var description: String = String()
    var keywords: [String] = []
    var isCollected: Bool = false {
        didSet {
            self.collectImage = UIImage(named: isCollected ? "Collection2" : "Collection1")
        }
    }
    var sellStatus: SellStatus = SellStatus.unavaliable
    var secondCategoryName: String = ""
    var createdTimeStr: String = String()
    var collectImage: UIImage? = UIImage(named: "Collection1")
    
    init() {
        
    }
    
    init(with treasure: TreasureListSearchDTO) {
        self.id = treasure.identifier ?? 0
        self.image = PathHandler.getImages(of: treasure.identifier).first
        self.title = treasure.name
        self.description = treasure.description
        self.keywords = treasure.keywords
        self.secondCategoryName = treasure.categoryName
        self.sellStatus = treasure.sellStatus
        self.isCollected = treasure.isCollected
        self.collectImage = UIImage(named: isCollected ? "Collection2" : "Collection1")
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

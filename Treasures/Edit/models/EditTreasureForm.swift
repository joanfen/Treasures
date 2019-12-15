//
//  EditTreasureForm.swift
//  Treasures
//
//  Created by joanfen on 2019/12/13.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import UIKit

class EditTreasureForm {
    var identifier: Int?
    var images: [UIImage] = []
    var name: String = ""
    var category: Category?
    var size: Size?
    var year: Int?
    var descrpiton: String = ""
    var keywords: [String] = []
    var purchasedYear: Int?
    var purchasedPrice: Float?
    var sellingPrice: Float?
    var available: Bool = false
    var isSold: Bool = false
    var note: String = ""
        
    private var table = TreasuresTable()
    
    init() {
        
    }
    
    init(with treasureDTO: TreasureDetailDTO) {
        let treasure = treasureDTO.treasureTable
        self.category = Category.init(firstCategory: CategoryInfo.init(id: treasure.firstCategoryId, name: treasureDTO.firstCategoryName),
                                      secondCategory: CategoryInfo.init(id: treasure.secondCategoryId, name: treasureDTO.secondCategoryName))
        
        self.identifier = treasure.identifier
        self.name = treasure.name
        self.table = treasure
        self.size = Size.init(length: treasure.length, width: treasure.width, height: treasure.height)
        self.year = treasure.year
        self.descrpiton = treasure.description
        self.keywords = treasure.keywords.components(separatedBy: ",")
        self.purchasedYear = treasure.purchasedYear
        self.purchasedPrice = Float(treasure.purchasedPriceInCent) / 100.0
        self.sellingPrice = Float(treasure.sellingPriceInCent) / 100.0
        self.available = treasure.available
        self.isSold = treasure.isSold
        self.note = treasure.note
        
        self.images = PathHandler.getImages(of: self.identifier)
    }
    
    public func categoryString() -> String {
        category?.getName() ?? ""
    }
    public func sizeString() -> String {
        size?.getSizeString() ?? ""
    }
    
    private func getTreasureTable() -> String? {
        table.identifier = identifier
        table.name = name
        table.description = descrpiton
        table.note = note
        table.available = available
        table.isSold = isSold
        if let s = size {
            table.width = s.width
            table.length = s.length
            table.height = s.height
            table.volume = s.getVolume()
        } else {
            // TODO: Block Action
          
        }
        if let c = category {
            table.firstCategoryId = c.firstCategory.id
            table.secondCategoryId = c.secondCategory.id
        } else {
            // TODO: Block ACTION
        }
        if let y = year {
            table.year = y
        } else {
            // TODO: Block ACTION
        }
        
        if let py = purchasedYear {
            table.purchasedYear = py
        } else {
            // TODO: BLOCK
        }
        
        if let pp = purchasedPrice {
            table.purchasedPriceInCent = Int64(pp) * 100
        } else {
            // TODO: BLOCK
        }
        
        if let sp = sellingPrice {
            table.sellingPriceInCent = Int64(sp) * 100
        } else {
            // TODO:
        }
        return nil
        
    }
    
    // 存入数据库
    public func saveOrUpdate() {
        
        self.descrpiton = "我更了一下描述你看见了吗"
        let _ = getTreasureTable()
        let id = TreasureRepository.insertOrReplace(treasure: self.table)
        saveImages(with: id)
    
    }
    
    public func saveImages(with treasureId: Int?) {
        if let id = treasureId {
            PathHandler.saveImage(of: id, imgs: self.images)
        }
    }
}

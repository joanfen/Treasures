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
    var imageUrls: [String]  = []
    var name: String = ""
    var category: Category?
    var size: String = ""
    var year: String = ""
    var descrpiton: String = ""
    var keywords: [String] = []
    var purchasedYear: Int?
    var purchasedPrice: Float?
    var sellingPrice: Float?
    var sellStatus: SellStatus = .unavaliable
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
        self.size = treasure.size
        self.year = treasure.year
        self.descrpiton = treasure.description
        self.keywords = treasure.keywords.components(separatedBy: ",")
        self.purchasedYear = treasure.purchasedYear
        self.purchasedPrice = Float(treasure.purchasedPriceInCent) / 100.0
        self.sellingPrice = Float(treasure.sellingPriceInCent) / 100.0
        self.sellStatus = SellStatus(rawValue: treasure.sellStatus) ?? SellStatus.unavaliable
        self.note = treasure.note
        
        self.images = PathHandler.getImages(of: self.identifier)
        self.imageUrls = PathHandler.getImagePaths(of: self.identifier)
    }
    
    public func categoryString() -> String {
        category?.getName() ?? ""
    }
   
    private func getTreasureTable() -> String? {
        table.identifier = identifier
        table.name = name
        table.description = descrpiton
        table.note = note
        table.sellStatus = sellStatus.rawValue
        table.size = size
        
        if let c = category {
            table.firstCategoryId = c.firstCategory.id
            table.secondCategoryId = c.secondCategory.id
        } else {
            // TODO: Block ACTION
        }
        table.year = year
        
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
    public func saveOrUpdate() -> Bool {
        let _ = getTreasureTable()
        let id = TreasureRepository.insertOrReplace(treasure: self.table)
        if let treasureId = id {
             return saveImages(with: treasureId)
        } else {
            return false
        }
    }
    
    public func saveImages(with treasureId: Int) -> Bool {
        return PathHandler.saveImage(of: treasureId, imgs: self.images)
    }
}

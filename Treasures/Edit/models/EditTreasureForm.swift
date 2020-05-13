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
    var deleted: Bool = false
    
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
        self.keywords = treasure.keywords.componentsExcludeWhiteSpace(by: ",")
        self.purchasedYear = treasure.purchasedYear
        self.purchasedPrice = Float(treasure.purchasedPriceInCent) / 100.0
        self.sellingPrice = Float(treasure.sellingPriceInCent) / 100.0
        self.sellStatus = SellStatus(rawValue: treasure.sellStatus) ?? SellStatus.unavaliable
        self.note = treasure.note
        self.deleted = treasure.deleted
        self.images = PathHandler.getImages(of: self.identifier)
        self.imageUrls = PathHandler.getImagePaths(of: self.identifier)
    }
    
    public func categoryString() -> String {
        category?.getName() ?? ""
    }
   
    private func getTreasureTable() -> String? {
        if let c = category {
            table.firstCategoryId = c.firstCategory.id
            table.secondCategoryId = c.secondCategory.id
        } else {
            // TODO: Block ACTION
            return "请选择类目"
        }
        
        if name.count == 0 {
            return "请填写名称"
        }
        table.identifier = identifier
        table.name = name
        table.description = descrpiton
        table.note = note
        table.sellStatus = sellStatus.rawValue
        table.size = size
        table.keywords = self.keywords.joined(separator: ",")
        
        table.year = year
        
        if let py = purchasedYear {
            table.purchasedYear = py
        }
        
        if let pp = purchasedPrice {
            table.purchasedPriceInCent = Int64(pp) * 100
        }
        
        if let sp = sellingPrice {
            table.sellingPriceInCent = Int64(sp) * 100
        }
        return nil
    }
    
    // 存入数据库
    public func saveOrUpdate() -> String? {
        let string: String? = getTreasureTable()
        if let str = string {
            return str
        }
        let id = TreasureRepository.insertOrReplace(treasure: self.table)
        if let treasureId = id {
            if (saveImages(with: treasureId) && saveKeywords()) {
               return nil
            }
        }
        return "操作失败"
    }
    
    public func saveImages(with treasureId: Int) -> Bool {
        return PathHandler.saveImage(of: treasureId, imgs: self.images)
    }
    
    public func saveKeywords() -> Bool {
        return KeywordsRepo.saveKeywords(keywords: self.keywords)
    }
    
    
}

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
    var purchasedPrice: Int64?
    var sellingPrice: Int64?
    var available: Bool = false
    var isSold: Bool = false
    var note: String = ""
        
    private var table = TreasuresTable()
    
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
            table.purchasedPriceInCent = pp
        } else {
            // TODO: BLOCK
        }
        
        if let sp = sellingPrice {
            table.sellingPriceInCent = sp
        } else {
            // TODO:
        }
        return nil
        
    }
    
    // 存入数据库
    public func saveOrUpdate() {
        
    }
    
    public func saveImages() {
        
    }
}

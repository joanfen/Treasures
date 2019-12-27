//
//  KeywordsRepo.swift
//  Treasures
//
//  Created by joanfen on 2019/12/27.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation

class KeywordsRepo {
    class func saveKeywords(keywords: [String]) -> Bool {
        let keywordTableO = keywords.map { (keyword) -> KeywordsTable in
            let table = KeywordsTable()
            table.name = keyword
            return table
        }
        do {
           try DatabaseHandler.getMainDatabase().insertOrReplace(objects: keywordTableO, intoTable: DBConstants.keywordsTable)
        } catch let ex {
            print(ex)
            return false
        }
        return true
    }
    
    class func queryKeywords() -> [String] {
        do {
            let objects: [KeywordsTable] = try DatabaseHandler.getMainDatabase().getObjects(on: KeywordsTable.Properties.all, fromTable: DBConstants.keywordsTable)
            return objects.map { (keywords) -> String in
                return keywords.name ?? ""
            }
        } catch _ {
        
        }
        return []
    }
    
}

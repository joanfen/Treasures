//
//  TreasureRepository.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import WCDBSwift

class TreasureRepository {
    /*
     * 查询已收藏藏品
     */
    class func findCollectedTreasures() -> [TreasureCellVO] {
        let filter = FilterPreference()
        filter.filterCollected = true
        return findTreasures(query: filter).map { (treasure) -> TreasureCellVO in
            return TreasureCellVO.init(with: treasure)
        }
    }
    
    /**
     * 查询已删除藏品
     */
    class func findDeletedTreasures() -> [TreasureCellVO] {
        let filter = FilterPreference()
        filter.filterDeleted = true
        return findTreasures(query: filter).map { (treasure) -> TreasureCellVO in
            return TreasureCellVO.init(with: treasure)
        }
    }
    
    
    /**
     * 分页查询藏品数据
     * @note base 查询
     */
    class func findTreasures(query: Queryable) -> [TreasureListSearchDTO] {
        var treasures = [TreasureListSearchDTO]()
        do {
            let multiSelect = try DatabaseHandler.getMainDatabase().prepareMultiSelect(
                    on: query.toProperties(),
                    fromTables: [DBConstants.treasuresTable, DBConstants.secondCategoryTable])
                .where(query.toQueryConditions())
                .order(by: query.toOrderBy())
            while let multiObject = try multiSelect.nextMultiObject() {
                let treasure = multiObject[DBConstants.treasuresTable] as? TreasuresTable
                let category = multiObject[DBConstants.secondCategoryTable] as? SecondCategoryTable
                if let object = treasure {
                    treasures.append(TreasureListSearchDTO.init(with: object, categoryName: category?.name))
                }
            }
            return treasures
        }
        catch let exception {
            print(exception)
        }
        return treasures
    }
    
    // MARK: - 更新藏品状态
    class func collectTreasureBy(id: Int) -> Bool {
        updateCollected(id: id, collected: true)
    }
    
    class func uncollectTreasureBy(id: Int) -> Bool {
        updateCollected(id: id, collected: false)
    }
    
    
    // MARK: - 更新藏品删除状态
    static func deleteTreasureBy(id: Int) -> Bool {
        updateDeleted(id: id, deleted: true)
    }
    
    static func revertDeleteTreasureBy(id: Int) -> Bool {
        updateDeleted(id: id, deleted: false)
    }
    
    static func clearTrash() -> Bool {
        do {
            try DatabaseHandler.getMainDatabase().delete(fromTable: DBConstants.treasuresTable, where: TreasuresTable.Properties.deleted == true)
        } catch let x {
            print(x)
            return false
        }
        return true
    }
    
    
    // MARK: - 查询藏品详情
    func findTreasureDetailWith(id: Int) -> TreasureDetailDTO {
        let dto = TreasureDetailDTO()
        do {
            var properties = DBConstants.treasureProperties
            properties.append(contentsOf: DBConstants.firstCategoryProperties)
            properties.append(contentsOf: DBConstants.secondCategoryProperties)
            
            let multiSelect = try DatabaseHandler.getMainDatabase().prepareMultiSelect(
                on: properties,
                fromTables: [DBConstants.treasuresTable,
                             DBConstants.firstCategoryTable,
                             DBConstants.secondCategoryTable])
                .where(TreasuresTable.Properties.identifier.in(table: DBConstants.treasuresTable) == id
                    && TreasuresTable.Properties.firstCategoryId == FirstCategoryTable.Properties.identifier.in(table: DBConstants.firstCategoryTable)
                    && TreasuresTable.Properties.secondCategoryId == SecondCategoryTable.Properties.identifier.in(table: DBConstants.secondCategoryTable))
            while let multiObject = try multiSelect.nextMultiObject() {
                let treasure = multiObject[DBConstants.treasuresTable] as? TreasuresTable
                let first = multiObject[DBConstants.firstCategoryTable] as? FirstCategoryTable
                let second = multiObject[DBConstants.secondCategoryTable] as? SecondCategoryTable
                dto.treasureTable = treasure ?? TreasuresTable()
                dto.firstCategoryName = first?.name ?? ""
                dto.secondCategoryName = second?.name ?? ""
                return dto
            }
            
        } catch let ex {
            print(ex)
        }
        return dto
    }
    
    /**
     * 新增or更新藏品
     */
    static public func insertOrReplace(treasure: TreasuresTable) -> Int?  {
        do {
            try DatabaseHandler.getMainDatabase().insertOrReplace(objects: treasure, intoTable: DBConstants.treasuresTable)
        } catch let exception {
            print("藏品数据更新失败: ")
            print(exception)
        }
        if let id = treasure.identifier {
            return id
        } else {
            return getMaxID()
        }
    }
    
    static public func getMaxID() -> Int? {
         do {
            let statement = StatementSelect()
            statement.select(TreasuresTable.Properties.identifier.max())
            statement.from(DBConstants.treasuresTable)
            let coreStatement = try DatabaseHandler.getMainDatabase().prepare(statement)
            while try coreStatement.step() {
                let id = coreStatement.value(atIndex: 0)
                return Int(id.int32Value)
            }
               
         } catch _ {
            
        }
        return nil
    }
    
    class internal func updateCollected(id: Int, collected: Bool) -> Bool {
        let treasure = TreasuresTable()
        treasure.isCollected = collected
        do {
            try DatabaseHandler.getMainDatabase().update(table: DBConstants.treasuresTable,
                           on: TreasuresTable.Properties.isCollected,
                           with: treasure,
                           where: TreasuresTable.Properties.identifier == id)
               
            return true
        } catch let ex {
            print("更新收藏状态失败: ")
            print(ex)
        }
        return false
    }
    
    class internal func updateDeleted(id: Int, deleted: Bool) -> Bool {
        let treasure = TreasuresTable()
        treasure.deleted = deleted
        do {
             try DatabaseHandler.getMainDatabase().update(table: DBConstants.treasuresTable,
                          on: TreasuresTable.Properties.deleted,
                          with: treasure,
                          where: TreasuresTable.Properties.identifier == id)
              
            return true
        } catch let ex {
            print("更新删除状态失败: ")
            print(ex)
        }
        return false
    }
    
    /**
     * 统计数量
     */
    class func getDataStatistic() -> CountVO {
        let count = CountVO()
        count.treasureCount = getTreasureCount()
        count.purchasedTotalFee = getPurchasedTotalFee()
        count.soldTotalFee = getSoldTotalFee()
        return count
    }
    
    /**
     *  获取藏品总数
     */
    class internal func getTreasureCount() -> Int {
        
        do {
            let statement = StatementSelect().select(TreasuresTable.Properties.identifier.count()).from(DBConstants.treasuresTable)
            let coreStatement = try DatabaseHandler.getMainDatabase().prepare(statement)
            while try coreStatement.step() {
                return coreStatement.value(atIndex: 0) ?? 0
            }
        } catch let ex {
            print(ex)
        }
        return 0
    }
    
    /**
     * 获取总进价
     */
    class internal func getPurchasedTotalFee() -> Float {
        
        do {
            let statement = StatementSelect().select(TreasuresTable.Properties.purchasedPriceInCent.sum()).from(DBConstants.treasuresTable)
            let coreStatement = try DatabaseHandler.getMainDatabase().prepare(statement)
            while try coreStatement.step() {
                let fee: Int = coreStatement.value(atIndex: 0) ?? 0
                return Float(fee) / Float(100)
            }
        } catch let ex {
            print(ex)
        }
        return Float(0)
    }
    
    /**
    * 获取总售价
    */
    class internal func getSoldTotalFee() -> Float {
        
        do {
            let statement = StatementSelect().select(TreasuresTable.Properties.sellingPriceInCent.sum()).from(DBConstants.treasuresTable).where(TreasuresTable.Properties.sellStatus == SellStatus.sold.rawValue)
            let coreStatement = try DatabaseHandler.getMainDatabase().prepare(statement)
            while try coreStatement.step() {
                let fee: Int = coreStatement.value(atIndex: 0) ?? 0
                return Float(fee) / Float(100)
            }
        } catch let ex {
            print(ex)
        }
        return 0
    }
}

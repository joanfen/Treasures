//
//  ListFilterView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/5.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

struct ListFilterViewConstants {
    static let pointY: CGFloat = 80
    static let nibName = "ListFilterView"
    static let categoryStr = "类目"
    static let avaliableStr = "可售"
    static let unavaliableStr = "不可售"
    static let soldStr = "已售"

}


class ListFilterView: UIView {
    
    @IBOutlet weak var yearContentView: UIView!
    @IBOutlet weak var sizeContentView: UIView!
    @IBOutlet weak var priceContentView: UIView!
    @IBOutlet weak var categoryContentView: UIView!
    @IBOutlet weak var avaliableContentView: UIView!
    @IBOutlet weak var unavaliableContentView: UIView!
    @IBOutlet weak var soldContentView: UIView!
    typealias FilterBegin = (_ with: FilterPreference) -> Void
    var filterBegin: FilterBegin?
    
    
    var filterPreference: FilterPreference = FilterPreference()
    
    var yearItem: SortedItem = SortedItem.loadYearXib()
    var sizeItem: SortedItem = SortedItem.loadXib()
    var priceItem: SortedItem = SortedItem.loadRightAlignNib()
    var categoryItem: CategoryItem = CategoryItem.loadXib()
    var avaliableItem: PropertyItem = PropertyItem.loadXib()
    var unavaliableItem: PropertyItem = PropertyItem.loadXib()
    var soldItem: PropertyItem = PropertyItem.loadXib()

    
    class func loadXib() -> ListFilterView {
        return Bundle.main.loadNibNamed("ListFilterView", owner: self, options: nil)!.first as! ListFilterView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.frame = CGRect.init(x: 0,
                                 y: ListFilterViewConstants.pointY,
                                 width: UISizeConstants.screenWidth,
                                 height: self.height)
        
        configItems()
        addSubviews()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutItems()
    }
    
    // MARK: - 设置排序规则
    private func updateSizeRule(rule: OrderRule) {
        self.filterPreference.sizeOrderRule = rule
        if rule != OrderRule.none {
           self.yearItem.updateOrderRule(rule: OrderRule.none)
           self.priceItem.updateOrderRule(rule: OrderRule.none)
        }
        self.filterBegin?(filterPreference)
    }
    
    private func updateYearRule(rule: OrderRule) {
        self.filterPreference.yearOrderRule = rule
        if rule != OrderRule.none {
          self.sizeItem.updateOrderRule(rule: OrderRule.none)
          self.priceItem.updateOrderRule(rule: OrderRule.none)
        }
    }
    
    private func updatePriceRule(rule: OrderRule) {
        self.filterPreference.priceOrderRule = rule
        if rule != OrderRule.none {
           self.yearItem.updateOrderRule(rule: OrderRule.none)
           self.sizeItem.updateOrderRule(rule: OrderRule.none)
        }
        testImageWrite()
    }
    
    func testImageWrite() {
        PathHandler.saveImage(of: 1, img: ImageConstants.downHiglight!, name: "down.png")
        let image = PathHandler.getImage(of: 1, imgName: "down.png")
        print(image ?? "no value")
    }

    // MARK: UI 控件 配置
    private func configItems() {
        configItemApperance()
        configItemActions()
    }
       
    // MARK: 配置点击代理事件
    private func configItemActions() {
        yearItem.ruleUpdated = { (rule: OrderRule) in
            self.updateYearRule(rule: rule)
        }
        
        sizeItem.ruleUpdated = { (rule: OrderRule) in
            self.updateSizeRule(rule: rule)
        }

        priceItem.ruleUpdated = { (rule: OrderRule) in
            self.updatePriceRule(rule: rule)
        }
    }

    private func configItemApperance() {
        avaliableItem.title = ListFilterViewConstants.avaliableStr
        unavaliableItem.title = ListFilterViewConstants.unavaliableStr
        soldItem.title = ListFilterViewConstants.soldStr
    }
    
    private func addSubviews() {
        yearContentView.addSubview(yearItem)
        sizeContentView.addSubview(sizeItem)
        priceContentView.addSubview(priceItem)
        categoryContentView.addSubview(categoryItem)
        avaliableContentView.addSubview(avaliableItem)
        unavaliableContentView.addSubview(unavaliableItem)
        soldContentView.addSubview(soldItem)
    }
    
    private func layoutItems() {
        yearItem.frame = yearContentView.bounds
        sizeItem.frame = sizeContentView.bounds
        priceItem.frame = priceContentView.bounds
        categoryItem.frame = categoryContentView.bounds
        avaliableItem.frame = avaliableContentView.bounds
        unavaliableItem.frame = unavaliableContentView.bounds
        soldItem.frame = soldContentView.bounds
    }
}


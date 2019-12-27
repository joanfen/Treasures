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
    private var yearItem: SortedItem = SortedItem.loadYearXib()
    private var keywordItem: KeywordItem = KeywordItem.loadXib()
    private var priceItem: SortedItem = SortedItem.loadRightAlignNib()
    private var categoryItem: CategoryItem = CategoryItem.loadXib()
    private var avaliableItem: PropertyItem = PropertyItem.loadXib()
    private var unavaliableItem: PropertyItem = PropertyItem.loadXib()
    private var soldItem: PropertyItem = PropertyItem.loadXib()
    
    typealias FilterBegin = (_ with: FilterPreference) -> Void
    open var filterBegin: FilterBegin?
    open var filterPreference: FilterPreference = FilterPreference()
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
    
    private func updateYearRule(rule: OrderRule) {
        self.filterPreference.yearOrderRule = rule
        if rule != OrderRule.none {
          self.priceItem.updateOrderRule(rule: OrderRule.none)
        }
        self.filterBegin?(filterPreference)
    }
    
    private func updatePriceRule(rule: OrderRule) {
        self.filterPreference.priceOrderRule = rule
        if rule != OrderRule.none {
           self.yearItem.updateOrderRule(rule: OrderRule.none)
        }
        self.filterBegin?(filterPreference)
    }
    
    private func updateFilterAvaliable(flag: Bool) {
        self.filterPreference.filterAvaliable = flag
        self.filterBegin?(filterPreference)
    }
    
    private func updateFilterUnavaliable(flag: Bool) {
        self.filterPreference.filterUnavaliable = flag
        self.filterBegin?(filterPreference)
    }
    
    private func updateFilterSold(flag: Bool) {
        self.filterPreference.filterSold = flag
        self.filterBegin?(filterPreference)
    }
    
    private func updateFilterCategory(category: CategoryInfo?) {
        self.filterPreference.category = category
        self.filterBegin?(filterPreference)
    }
    
    private func updateFilterKeyword(keyword: String?) {
        filterPreference.keyword = keyword
        filterBegin?(filterPreference)
    }

    // MARK: UI 控件 配置
    private func configItems() {
        configItemApperance()
        configItemActions()
    }
       
    // MARK: 配置点击代理事件
    private func configItemActions() {
        keywordItem.selectedAction = { (keyword) in
            self.updateFilterKeyword(keyword: keyword)
        }
        categoryItem.selectCategoryAction = { (category ) in
            self.updateFilterCategory(category: category)
        }
        
        yearItem.ruleUpdated = { (rule: OrderRule) in
            self.updateYearRule(rule: rule)
        }

        priceItem.ruleUpdated = { (rule: OrderRule) in
            self.updatePriceRule(rule: rule)
        }
        avaliableItem.selectedAction = { (selected: Bool) in
            self.updateFilterAvaliable(flag: selected)
        }
        unavaliableItem.selectedAction = { (selected: Bool) in
            self.updateFilterUnavaliable(flag: selected)
        }
        soldItem.selectedAction = { (selected: Bool) in
            self.updateFilterSold(flag: selected)
        }
        
    }

    private func configItemApperance() {
        avaliableItem.title = ListFilterViewConstants.avaliableStr
        unavaliableItem.title = ListFilterViewConstants.unavaliableStr
        soldItem.title = ListFilterViewConstants.soldStr
    }
    
    private func addSubviews() {
        yearContentView.addSubview(yearItem)
        sizeContentView.addSubview(keywordItem)
        priceContentView.addSubview(priceItem)
        categoryContentView.addSubview(categoryItem)
        avaliableContentView.addSubview(avaliableItem)
        unavaliableContentView.addSubview(unavaliableItem)
        soldContentView.addSubview(soldItem)
    }
    
    private func layoutItems() {
        yearItem.frame = yearContentView.bounds
        keywordItem.frame = sizeContentView.bounds
        priceItem.frame = priceContentView.bounds
        categoryItem.frame = categoryContentView.bounds
        avaliableItem.frame = avaliableContentView.bounds
        unavaliableItem.frame = unavaliableContentView.bounds
        soldItem.frame = soldContentView.bounds
    }
}


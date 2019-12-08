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
    
    var yearItem: YearFilterItem = YearFilterItem.loadXib()
    var sizeItem: SortedItem = SortedItem.loadXib()
    var priceItem: SortedItem = SortedItem.loadRightAlignNib()
    var categoryItem: CategoryItem = CategoryItem.loadXib()
    var avaliableItem: CategoryItem = CategoryItem.loadXib()
    var unavaliableItem: CategoryItem = CategoryItem.loadXib()
    var soldItem: CategoryItem = CategoryItem.loadXib()

    
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
    
    func configItems() {
        categoryItem.title = ListFilterViewConstants.categoryStr
        avaliableItem.title = ListFilterViewConstants.avaliableStr
        unavaliableItem.title = ListFilterViewConstants.unavaliableStr
        soldItem.title = ListFilterViewConstants.soldStr
    }
    
    func addSubviews() {
        yearContentView.addSubview(yearItem)
        sizeContentView.addSubview(sizeItem)
        priceContentView.addSubview(priceItem)
        categoryContentView.addSubview(categoryItem)
        avaliableContentView.addSubview(avaliableItem)
        unavaliableContentView.addSubview(unavaliableItem)
        soldContentView.addSubview(soldItem)
    }
    
    func layoutItems() {
        yearItem.frame = yearContentView.bounds
        sizeItem.frame = sizeContentView.bounds
        priceItem.frame = priceContentView.bounds
        categoryItem.frame = categoryContentView.bounds
        avaliableItem.frame = avaliableContentView.bounds
        unavaliableItem.frame = unavaliableContentView.bounds
        soldItem.frame = soldContentView.bounds
    }
    
}


//
//  ListFilterView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/5.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class ListFilterView: UIView {
    
    @IBOutlet weak var yearContentView: UIView!
    
    @IBOutlet weak var sizeContentView: UIView!
    
    @IBOutlet weak var priceContentView: UIView!
    
    var yearItem: YearFilterItem = YearFilterItem.loadXib()
    var sizeItem: SortedItem = SortedItem.loadXib()
    var priceItem: SortedItem = SortedItem.loadRightAlignNib()
    
    class func loadXib() -> ListFilterView {
        return Bundle.main.loadNibNamed("ListFilterView", owner: self, options: nil)!.first as! ListFilterView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let height = self.frame.size.height
        self.frame = CGRect.init(x: 0, y: 80, width: UISizeConstants.screenWidth, height: height)
        yearContentView.addSubview(yearItem)

        sizeContentView.addSubview(sizeItem)
        
        priceContentView.addSubview(priceItem)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        yearItem.frame = yearContentView.bounds
        sizeItem.frame = sizeContentView.bounds
        priceItem.frame = priceContentView.bounds

    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
}


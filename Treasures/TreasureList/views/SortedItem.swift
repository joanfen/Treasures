//
//  SortedItem.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/7.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

enum OrderRule {
    case none
    case asc
    case desc
    
    func next() -> OrderRule {
        switch self {
        case .asc: // 从升序到降序
            return OrderRule.desc
        case .desc: // 从降序到取消排序
            return OrderRule.none
        case .none: // 从取消排序到升序
            return OrderRule.asc
        }
    }
}

struct SortedItemConstants {
    static let centerAlignNib = "SortedItem"
    static let rightAlignNib = "PriceItem"
}

class SortedItem: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upImgView: UIImageView!
    @IBOutlet weak var downImgView: UIImageView!
    @IBOutlet weak var highlightBar: UIView!
    
    open var orderRule: OrderRule = OrderRule.none
    open var title = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
   
    class func loadXib() -> SortedItem {
        return Bundle.main.loadNibNamed(SortedItemConstants.centerAlignNib, owner: self, options: nil)!.first as! SortedItem
    }
    
    class func loadRightAlignNib() -> SortedItem {
          return Bundle.main.loadNibNamed(SortedItemConstants.rightAlignNib, owner: self, options: nil)!.first as! SortedItem
      }
       
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func clearOrder() {
        orderRule = OrderRule.none
    }
    
    @IBAction func selectedAction(_ sender: Any) {
        orderRule = orderRule.next()
        highlightImage()
        showOrHiddenBar()
    }
    
    func highlightImage() {
        upImgView.image = orderRule == OrderRule.asc ? ImageConstants.upHighlight : ImageConstants.upNormal
        downImgView.image = orderRule == OrderRule.desc ? ImageConstants.downHiglight : ImageConstants.downNormal
    }
    
    func showOrHiddenBar() {
        highlightBar.isHidden = orderRule == OrderRule.none
    }
    
}

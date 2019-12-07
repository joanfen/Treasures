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
        case .asc:
            return OrderRule.desc
        default:
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
    
    var orderRule: OrderRule = OrderRule.none
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
        
        upImgView.image = UIImage.init(named: orderRule == OrderRule.asc ? "up2" : "up1")
        downImgView.image = UIImage.init(named: orderRule == OrderRule.desc ? "down2" : "down1")
    }
    
    
    
    
}

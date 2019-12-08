//
//  SortedItem.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/7.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

struct SortedItemConstants {
    static let yearNib = "SortYearItem"
    static let centerAlignNib = "SortedItem"
    static let rightAlignNib = "SortPriceItem"
}

class SortedItem: UIView {

    typealias RuleUpdated = (_ rule: OrderRule) -> Void
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upImgView: UIImageView!
    @IBOutlet weak var downImgView: UIImageView!
    @IBOutlet weak var highlightBar: UIView!
    private var orderRule: OrderRule = OrderRule.none
    
    open var ruleUpdated: RuleUpdated?
    
    open var title = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    func updateOrderRule(rule: OrderRule) {
        if (rule != orderRule) {
            orderRule = rule
            updateUI()
            ruleUpdated?(orderRule)
        }
        
    }
    
   
    // MARK: - load nib
    class func loadXib() -> SortedItem {
        return Bundle.main.loadNibNamed(SortedItemConstants.centerAlignNib, owner: self, options: nil)!.first as! SortedItem
    }
    /**
     * 年份视图
     */
    class func loadYearXib() -> SortedItem {
        return Bundle.main.loadNibNamed(SortedItemConstants.yearNib, owner: self, options: nil)!.first as! SortedItem
    }
    
    class func loadRightAlignNib() -> SortedItem {
          return Bundle.main.loadNibNamed(SortedItemConstants.rightAlignNib, owner: self, options: nil)!.first as! SortedItem
      }
       
    // MARK: - override
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - protocol
    
    
    // MARK: - action
    @IBAction private func selectedAction(_ sender: Any) {
        updateOrderRule(rule: orderRule.next())
    }
    
    // MARK: - UI config
    private func updateUI() {
        highlightImage()
        showOrHiddenBar()
    }
    
    private func highlightImage() {
        upImgView.image = orderRule == OrderRule.asc ? ImageConstants.upHighlight : ImageConstants.upNormal
        downImgView.image = orderRule == OrderRule.desc ? ImageConstants.downHiglight : ImageConstants.downNormal
    }
    
    private func showOrHiddenBar() {
        highlightBar.isHidden = orderRule == OrderRule.none
    }
    
}

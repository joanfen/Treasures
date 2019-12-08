//
//  YearFilterView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/7.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class YearFilterItem: UIView {
    @IBOutlet weak var arrowView: UIImageView!
    @IBOutlet weak var highlightBar: UIView!
    @IBOutlet weak var actionBtn: UIButton!
    
    open var isSelected: Bool = false
    
    class func loadXib() -> YearFilterItem {
          return Bundle.main.loadNibNamed("YearFilterItem", owner: self, options: nil)!.first as! YearFilterItem
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func selectAction(_ sender: Any) {
        isSelected = !isSelected
        changeUI()
        // TODO: 传递点击事件
    }
    
    // MARK: - UI 配置修改
    func changeUI() {
        showOrHiddenBar()
        rotateArrow()
    }
    
    func rotateArrow() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        self.arrowView.transform = self.arrowView.transform.rotated(by: CGFloat(-Double.pi))
        self.arrowView.image = isSelected ? ImageConstants.downHiglight : ImageConstants.downNormal
        UIView.commitAnimations()
    }
    
    func showOrHiddenBar() {
        highlightBar.isHidden = !isSelected
    }
    
}

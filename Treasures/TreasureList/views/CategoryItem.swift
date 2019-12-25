//
//  CategoryItem.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class CategoryItem: UIView {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var bgBottomConstraint: NSLayoutConstraint!
    var isSelected: Bool = false
    
    class func loadXib() -> CategoryItem {
        return Bundle.main.loadNibNamed("CategoryItem", owner: self, options: nil)!.first as! CategoryItem
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 16
    }

    @IBAction func selectAction(_ sender: Any) {
        isSelected = !isSelected
        changeUI()
    }
    
    // MARK: - UI 修改
    func changeUI() {
        rotateArrow()
        changeTextColor()
        changeBgView()
    }
    
    func rotateArrow() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        self.imgView.transform = self.imgView.transform.rotated(by: CGFloat(-Double.pi))
        self.imgView.image = isSelected ? ImageConstants.downHiglight : ImageConstants.downNormal
        UIView.commitAnimations()
    }
    
    func changeBgView() {
        self.bgBottomConstraint.constant = isSelected ? -10 : 10
        layoutIfNeeded()

    }
    
    func changeTextColor() {
           self.titleLabel.textColor = isSelected ? ColorConstants.globalMainColor : ColorConstants.titleColor
    }
    
}

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
    var picker: CategoryPickerForFilter?

    var isSelected: Bool = false
    var category: CategoryInfo?
    
    var selectCategoryAction: SelectSecondCategory?
    class func loadXib() -> CategoryItem {
        return Bundle.main.loadNibNamed("CategoryItem", owner: self, options: nil)!.first as! CategoryItem
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 16
        picker = CategoryPickerForFilter.init(with: 175, category: self.category)
        picker?.dismissAction = { (needSearch) in
            self.deselect()
            if needSearch {
                self.category = nil
                self.selectCategoryAction?(self.category)
            }
            
        }
        picker?.selectCategoryAction = { (category) in
            self.category = category
            self.selectCategoryAction?(category)
        }
    }

    @IBAction func selectAction(_ sender: Any) {
        isSelected = !isSelected
        changeUI()
        show()
    }
    
    // MARK: - UI 修改
    private func changeUI() {
        rotateArrow()
        changeTextColor()
        changeBgView()
    }
    
    private func rotateArrow() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        self.imgView.transform = self.imgView.transform.rotated(by: CGFloat(-Double.pi))
        self.imgView.image = isSelected ? ImageConstants.downHiglight : ImageConstants.downNormal
        UIView.commitAnimations()
    }
    
    private func changeBgView() {
        self.bgBottomConstraint.constant = isSelected ? -10 : 10
        layoutIfNeeded()

    }
   
    func show () {
        if isSelected {
            self.picker?.show(in: self.superview?.superview ?? self)
        } else {
            self.picker?.dismiss()
        }
    }
    
    func deselect() {
        isSelected = false
        self.changeUI()
    }
    
    func changeTextColor() {
           self.titleLabel.textColor = isSelected ? ColorConstants.globalMainColor : ColorConstants.titleColor
    }
    
}

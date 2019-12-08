//
//  CategoryItem.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/7.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class CategoryItem: UIView {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    var isSelected: Bool = false
    
    open var title: String = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    class func loadXib() -> CategoryItem {
           return Bundle.main.loadNibNamed("CategoryItem", owner: self, options: nil)!.first as! CategoryItem
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 16
        self.bgView.layer.borderColor = ColorConstants.globalMainColor.cgColor        
    }
    

    @IBAction func selectAction(_ sender: Any) {
        isSelected = !isSelected
        self.bgView.backgroundColor = isSelected ? ColorConstants.highlightBgColor : ColorConstants.normalItemBgColor
        self.titleLabel.textColor = isSelected ? ColorConstants.globalMainColor : ColorConstants.titleColor
        self.bgView.layer.borderWidth = isSelected ? 0.5 : 0
    }
    
}

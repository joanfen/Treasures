//
//  CategoryItem.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/7.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit
typealias SelectedAction = (_ selected: Bool) -> Void
class PropertyItem: UIView {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    private var isSelected: Bool = false
    
    
    var selectedAction: SelectedAction?
    
    open var title: String = "" {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    class func loadXib() -> PropertyItem {
           return Bundle.main.loadNibNamed("PropertyItem", owner: self, options: nil)!.first as! PropertyItem
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 16
        self.bgView.layer.borderColor = ColorConstants.globalMainColor.cgColor        
    }
    

    @IBAction func selectAction(_ sender: Any) {
        isSelected = !isSelected
        changeTextColor()
        changeLayerApperance()
        self.selectedAction?(isSelected)
    }
    
    func changeTextColor() {
        self.titleLabel.textColor = isSelected ? ColorConstants.globalMainColor : ColorConstants.titleColor
    }
    
    func changeLayerApperance() {
        self.bgView.backgroundColor = isSelected ? ColorConstants.highlightBgColor : ColorConstants.normalItemBgColor
        self.bgView.layer.borderWidth = isSelected ? 0.5 : 0
    }
    
}

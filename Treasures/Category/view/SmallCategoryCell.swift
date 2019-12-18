//
//  SmallCategoryCell.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/16.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class SmallCategoryCell: UITableViewCell {

    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.editBtn.layer.masksToBounds = true
        self.editBtn.layer.borderWidth = 1
        self.editBtn.layer.cornerRadius = 4
        self.countLbl.layer.masksToBounds = true
        self.countLbl.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.editBtn.setTitle("取消", for: .normal)
            self.editBtn.setTitleColor(UIColor.colorWithHexString(hex: "B2B2B2"), for: .normal)
            self.editBtn.layer.borderColor = UIColor.colorWithHexString(hex: "B2B2B2").cgColor
        }else {
            self.editBtn.setTitle("添加", for: .normal)
            self.editBtn.setTitleColor(UIColor.colorWithHexString(hex: "CB2424"), for: .normal)
            self.editBtn.layer.borderColor = UIColor.colorWithHexString(hex: "CB2424").cgColor
        }
//        self.editBtn.isSelected = !self.editBtn.isSelected
        // Configure the view for the selected state
    }
    
    @IBAction func editBtnClicked(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
    }
}

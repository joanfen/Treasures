//
//  BigCategoryCell.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/16.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class BigCategoryCell: UITableViewCell {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.lineView.isHidden = !selected
       if selected {
        self.titleLbl.textColor = UIColor.colorWithHexString(hex: "323232")
        }
        else{
           self.titleLbl.textColor = UIColor.colorWithHexString(hex: "B2B2B2")
        }
    }
    
}

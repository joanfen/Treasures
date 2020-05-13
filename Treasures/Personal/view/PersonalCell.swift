//
//  PersonalCell.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/15.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class PersonalCell: UITableViewCell {

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var rightLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reload(image:UIImage?,_ title:String, _ showRightLbl:Bool=false) {
        self.iconImg.image = image
        self.titleLbl.text = title
//        self.rightLbl.isHidden = !showRightLbl
        self.rightLbl.isHidden = true
    }
    
}

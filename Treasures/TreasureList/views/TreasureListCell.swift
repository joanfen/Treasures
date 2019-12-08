//
//  TreasureListCell.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

struct TreasureListCellConstants {
    static let nibName: String = "TreasureListCell"
    static let reuseId: String = "treasureListCell"
    static let height: CGFloat = 155
}

class TreasureListCell: UITableViewCell {

    class func loadXib() -> TreasureListCell {
        return Bundle.main.loadNibNamed(TreasureListCellConstants.nibName, owner: self, options: nil)!.first as! TreasureListCell
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

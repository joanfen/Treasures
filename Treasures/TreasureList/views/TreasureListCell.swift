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
    
    static func nib() -> UINib? {
        return UINib(nibName: nibName, bundle: nil)
    }
}

class TreasureListCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!

    func config(with source: TreasureCellVO) {
        self.imgView.image = source.image
        self.titleLabel.text = source.title
        self.descriptionLabel.text = source.description
        self.timeLabel.text = source.createdTimeStr
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func collectAction(_ sender: Any) {
        
    }
}

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
    
    @IBOutlet weak var collectedBtn: UIButton!
    var source: TreasureCellVO = TreasureCellVO.init()
    
    typealias ActionBlock = (_ hud: JGProgressHUD, _ collected: Bool) -> Void
    typealias LongPressAction = () -> Void
    var longPressAction: LongPressAction?
    
    var actionBlock: ActionBlock?

    
    func config(with source: TreasureCellVO) {
        self.imgView.image = source.image
        self.titleLabel.text = source.title
        self.descriptionLabel.text = source.description
        self.timeLabel.text = source.createdTimeStr
        self.source = source
        self.refreshCollectedStatus()
    }
    
    func config(with source: TreasureCellVO, actionBlock: ActionBlock?, longPressAction: LongPressAction?) {
        self.config(with: source)
        self.actionBlock = actionBlock
        self.longPressAction = longPressAction
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UILongPressGestureRecognizer.init(target: self, action: #selector(showActionAlert))
        tap.minimumPressDuration = 1
        self.addGestureRecognizer(tap)
    }
    
    @objc private func showActionAlert() {
        self.longPressAction?()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func refreshCollectedStatus() {
        self.collectedBtn.setImage(source.collectImage, for: UIControl.State.normal)
    }
    
    @IBAction func collectAction(_ sender: Any) {
       let collected = source.isCollected
        source.isCollected = !collected
        let result = TreasureRepository.updateCollected(id: source.id, collected: source.isCollected)
        
        let text = collected ? "取消收藏" : "收藏"
        self.refreshCollectedStatus()
        if result {
            self.actionBlock?(HUDHandler.successHUD(with: text + "成功"), source.isCollected)
        } else {
            self.actionBlock?(HUDHandler.errorHUD(with: text + "失败"), source.isCollected)
        }
        
    }
}

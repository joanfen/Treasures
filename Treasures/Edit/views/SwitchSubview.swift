//
//  SwitchSubview.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/18.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class SwitchSubview: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chooseBtn: UIButton!
    @IBOutlet var statusSegment: UISegmentedControl!
    
    typealias ChoosedAction = (_ sellStatus: SellStatus) -> Void
    private var chooseAction: ChoosedAction?
    
    private var sellStatus: SellStatus = .unavaliable
    
    class func loadXib() -> SwitchSubview {
         Bundle.main.loadNibNamed("SwitchSubview", owner: self, options: nil)!.first as! SwitchSubview
    }

    func dataSetting(title: String, sellStatus: SellStatus, choosedAction: @escaping ChoosedAction) {
        self.titleLabel.text = title
        self.sellStatus = sellStatus
        self.statusSegment.selectedSegmentIndex = sellStatus.rawValue
        self.chooseAction = choosedAction
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.statusSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: UIControl.State.selected)
        self.statusSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : ColorConstants.titleColor], for: UIControl.State.normal)
        
    }
    
    @IBAction func statusChanged(_ sender: Any) {
        sellStatus = SellStatus(rawValue: self.statusSegment.selectedSegmentIndex) ?? SellStatus.unavaliable
        self.chooseAction?(sellStatus)
    }
}

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
    
    typealias ChoosedAction = (_ choosed: Bool) -> Void
    private var chooseAction: ChoosedAction?
    
    private var choosed: Bool = false {
        didSet {
            self.chooseBtn.setImage(UIImage(named: choosed ? "chose2" : "chose1"), for: UIControl.State.normal)
        }
    }
    
    class func loadXib() -> SwitchSubview {
         Bundle.main.loadNibNamed("SwitchSubview", owner: self, options: nil)!.first as! SwitchSubview
    }

    func dataSetting(title: String, choosed: Bool, choosedAction: @escaping ChoosedAction) {
        self.titleLabel.text = title
        self.choosed = choosed
        self.chooseAction = choosedAction
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func chooseAction(_ sender: Any) {
        self.choosed = !self.choosed
        self.chooseAction?(choosed)
    }
}

//
//  EditPopView.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/19.
//  Copyright © 2019 joanfen. All rights reserved.
//

enum PopAction {
    case edit,copy,delete
}

import UIKit

class EditPopView: UIView {
    var ActionBlock:((_ action:PopAction) ->())?
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var effectView: UIVisualEffectView!
    
    class func loadXib() -> EditPopView {
        return Bundle.main.loadNibNamed("EditPopView", owner: self, options: nil)!.first as! EditPopView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        effectView.layer.masksToBounds = true
        effectView.layer.cornerRadius = 12
    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        var action = PopAction.edit
        switch sender {
        case editBtn:
            action = PopAction.edit
        case copyBtn:
            action = PopAction.copy
        default:
            action = PopAction.delete
        }
        if self.ActionBlock != nil {
            self.ActionBlock!(action)
        }
        self.closeBtnClicked()
    }
    
    @IBAction func closeBtnClicked() {
        self.removeFromSuperview()
    }
}

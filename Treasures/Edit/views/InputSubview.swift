//
//  InputSubview.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/12.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit


protocol InputViewDelegate {
    func textFieldBeginEditing(at bottom: CGFloat) -> Void
}

typealias TextChanged = (_ text: String) -> Void

class InputSubview: UIView, UITextFieldDelegate {

    @IBOutlet private var titleLable: UILabel!
    @IBOutlet private var textField: UITextField!
    
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet weak var unitWidth: NSLayoutConstraint!
    var textChanged: TextChanged?
    var delegate: InputViewDelegate?

    
    class func loadXib() -> InputSubview {
        Bundle.main.loadNibNamed("InputSubview", owner: self, options: nil)!.first as! InputSubview
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func showUnit(text: String) {
        unitWidth.constant = 34
        unitLabel.text = text
        self.layoutIfNeeded()
    }
    
    func dataSetting(title: String, value: String, textChanged: @escaping TextChanged, delegate: InputViewDelegate) {
        self.textField.text = value
        if(value == "0" || value == "0.0") {
            self.textField.text = ""
        }
        self.titleLable.text = title
        self.delegate = delegate
        self.textChanged = textChanged
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.textFieldBeginEditing(at: self.bottom)
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        self.textChanged?(textField.text ?? "")
    }
}

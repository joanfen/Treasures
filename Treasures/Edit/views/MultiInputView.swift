//
//  MultiInputView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/18.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit
class MultiInputView: UIView, UITextViewDelegate {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textView: UITextView!
    
    @IBOutlet private weak var line: UIView!
    var textField: UITextField?
    
    var textChanged: TextChanged?
    
    func dataSetting(title: String, value: String, textChanged: @escaping TextChanged) {
        self.titleLabel.text = title
        self.textView.text = value
        self.textChanged = textChanged
    
    }
    
    class func loadXib() -> MultiInputView {
         Bundle.main.loadNibNamed("MultiInputView", owner: self, options: nil)!.first as! MultiInputView
    }
    
    func hideSeperateLine() {
        self.line.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.layer.borderWidth = 0.25
        self.textView.layer.borderColor = ColorConstants.titleColor.cgColor
        self.textView.layer.cornerRadius = 4.0
     
    }
    
    override func resignFirstResponder() -> Bool {
        self.textView.resignFirstResponder()
    }
    
    internal func textViewDidEndEditing(_ textView: UITextView) {
        self.textChanged?(textView.text ?? "")
    }
    
    internal func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}

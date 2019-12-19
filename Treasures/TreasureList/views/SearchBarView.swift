//
//  SearchBarView.swift
//  Treasures
//
//  Created by joanfen on 2019/12/4.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class SearchBarView: UIView, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var fieldBgView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    typealias SearchBegin = (_ text: String?) -> Void
    var searchBegin: SearchBegin?
    
    class func loadXib() -> SearchBarView {
        return Bundle.main.loadNibNamed("SearchBarView", owner: self, options: nil)!.first as! SearchBarView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.fieldBgView.layer.cornerRadius = 4.0
    }
 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.searchBegin?(textField.text)
        return true
    }
}

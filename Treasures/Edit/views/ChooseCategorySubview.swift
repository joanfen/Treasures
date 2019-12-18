//
//  ChooseCategoryView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/12.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit
typealias Tap = () -> Void

class ChooseCategorySubview: UIView {

    @IBOutlet weak var textField: UITextField!
    
    var tapAction: Tap?
    
    var category: Category? {
        didSet {
            if let c = category {
                self.textField.text = c.secondCategory.name
            }
        }
    }
    
    class func loadXib() -> ChooseCategorySubview {
          return Bundle.main.loadNibNamed("ChooseCategorySubview", owner: self, options: nil)!.first as! ChooseCategorySubview
      }


    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction private func tap(_ sender: Any) {
        self.tapAction?()
    }
}

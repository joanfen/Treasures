//
//  SearchBarView.swift
//  Treasures
//
//  Created by joanfen on 2019/12/4.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class SearchBarView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var fieldBgView: UIView!
    
    @IBOutlet weak var textField: UITextField!
    
    class func loadXib() -> SearchBarView {
        return Bundle.main.loadNibNamed("SearchBarView", owner: self, options: nil)!.first as! SearchBarView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let frame = self.frame
        self.frame = CGRect.init(x: 0, y: 0, width: UISizeConstants.screenWidth, height: frame.size.height)
        self.fieldBgView.layer.cornerRadius = 4.0
    }
 
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

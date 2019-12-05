//
//  ListFilterView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/5.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class ListFilterView: UIView {
    
    class func loadXib() -> ListFilterView {
        return Bundle.main.loadNibNamed("ListFilterView", owner: self, options: nil)!.first as! ListFilterView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let height = self.frame.size.height
        self.frame = CGRect.init(x: 0, y: 80, width: UISizeConstants.screenWidth, height: height)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


//
//  ShareView.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/25.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class ShareView: UIView {
    @IBOutlet weak var sharedView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    
    class func loadXib() -> ShareView {
        return Bundle.main.loadNibNamed("ShareView", owner: self, options: nil)!.first as! ShareView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func reloadView(treasure:EditTreasureForm) {
        if treasure.images.count == 0 {
            imgHeight.constant = 0
        }else {
            img.image = treasure.images[0]
        }
        titleLbl.text = treasure.name
        desLbl.text = treasure.descrpiton
        sizeLbl.text = treasure.size.isEmpty ? "尺寸：--" : "尺寸：\(treasure.size)"
        yearLbl.text = treasure.year.isEmpty ? "年份：--" : "年份：\(treasure.year)"
    }

    @IBAction func friendBtnClicked() {
    }
    
    @IBAction func circleBtnClicked() {
    }
    
    @IBAction func dismissBtnClicked() {
        self.removeFromSuperview()
    }
}

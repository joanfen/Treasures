//
//  AddImagesView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/12.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit
struct AddImagesSubviewConstants {
    static let height: CGFloat = 174.0
    static let nibName = "AddImagesSubview"
}

class AddImagesSubview: UIView {

    @IBOutlet weak var addBtn1: AddImageButton!
    @IBOutlet weak var addBtn2: AddImageButton!
    @IBOutlet weak var addBtn3: AddImageButton!
    class func loadXib() -> AddImagesSubview {
        return Bundle.main.loadNibNamed(AddImagesSubviewConstants.nibName, owner: self, options: nil)!.first as! AddImagesSubview
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

class AddImageButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.cornerRadius = 4
        self.layer.borderColor = ColorConstants.titleColor.cgColor
        self.layer.borderWidth = 0.5
    }
}

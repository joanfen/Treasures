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
    
    typealias ShowAlbum = (_ tag: Int) -> UIImage
    typealias ShowAlert = (_ alert: UIAlertController) -> Void
    var showAlbum: ShowAlbum?
    var showAlert: ShowAlert?
    
    private var images: [UIImage] = []
    
    class func loadXib() -> AddImagesSubview {
        return Bundle.main.loadNibNamed(AddImagesSubviewConstants.nibName, owner: self, options: nil)!.first as! AddImagesSubview
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func addImage(with image: UIImage) {
        
    }
    

    @IBAction func addImage(_ sender: Any) {
        let btn = sender as! UIButton
        let tag = btn.tag
        
        let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(UIAlertAction.init(title: "移除", style: UIAlertAction.Style.destructive, handler: { (action) in
            
            btn.setImage(nil, for: UIControl.State.normal)
            self.images.remove(at: tag)
            
        }))
        alert.addAction(UIAlertAction.init(title: "相册", style: UIAlertAction.Style.default, handler: { (action) in
            self.showAlbum?(tag)
        }))
        
        self.showAlert?(alert)
        
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

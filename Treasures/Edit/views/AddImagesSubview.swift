//
//  AddImagesView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/12.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit
struct AddImagesSubviewConstants {
    static let height: CGFloat = 124
    static let nibName = "AddImagesSubview"
}

class AddImagesSubview: UIView {

    @IBOutlet weak var addBtn1: AddImageButton!
    @IBOutlet weak var addBtn2: AddImageButton!
    @IBOutlet weak var addBtn3: AddImageButton!
    
    typealias ShowAlbum = (_ tag: Int) -> Void
    typealias ShowAlert = (_ alert: UIAlertController) -> Void
    var showAlbum: ShowAlbum?
    var showAlert: ShowAlert?
    var selectedIndex: Int = 0
    
    var images: [UIImage] = [] {
        didSet {
            self.showImages()
        }
    }
    
    class func loadXib() -> AddImagesSubview {
        return Bundle.main.loadNibNamed(AddImagesSubviewConstants.nibName, owner: self, options: nil)!.first as! AddImagesSubview
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.showImages()
    }
    
    func getImages() -> [UIImage] {
        return self.images
    }
    
    func getImage(at index: Int) -> UIImage? {
        if images.count > index {
            return images[index]
        }
        return nil
    }
    
    func addImage(with image: UIImage) {
        images.append(image)
        self.showImages()
    }
    
    func removeImage(at index: Int) {
        if index < images.count {
            self.images.remove(at: index)
        }
        self.showImages()
    }
    
    private func showImages() {
        setImage(with: 0, button: addBtn1)
        setImage(with: 1, button: addBtn2)
        setImage(with: 2, button: addBtn3)
    }
    private func setImage(with index: Int, button: AddImageButton) {
        if let image = getImage(at: index) {
            button.setImage(image, for: UIControl.State.normal)
        } else {
            if #available(iOS 13.0, *) {
                button.setImage(UIImage.init(systemName: "plus"), for: UIControl.State.normal)
            } else {
                // Fallback on earlier versions
                button.setImage(nil, for: UIControl.State.normal)
                
            }
        }
    }
    

    @IBAction func addImage(_ sender: Any) {
        let btn = sender as! UIButton
        let tag = btn.tag
        
        let alert = UIAlertController.init(title: "请选择操作", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        alert.addAction(cancelAction())
        if (tag < images.count) {
            alert.addAction(albumAction(tag))
        }
        
        alert.addAction(UIAlertAction.init(title: "相册", style: UIAlertAction.Style.default, handler: { (action) in
            self.showAlbum?(tag)
        }))
        
        
        
        self.showAlert?(alert)
        
    }
    
    private func cancelAction() -> UIAlertAction {
        return UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: nil)
    }
    
    private func albumAction(_ tag: Int) -> UIAlertAction {
        return UIAlertAction.init(title: "移除", style: UIAlertAction.Style.destructive, handler: { (action) in
            self.removeImage(at: tag)
                    
        })
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

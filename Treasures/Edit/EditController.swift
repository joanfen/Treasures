//
//  EditController.swift
//  Treasures
//
//  Created by joanfen on 2019/12/4.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class EditController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let imagesView = AddImagesSubview.loadXib()
    private let contentView = UIScrollView()
    private let categoryView = ChooseCategorySubview.loadXib()
    var treasureId: Int?
    var edit: EditTreasureForm = EditTreasureForm()

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(withId id: Int) {
        self.init()
        self.treasureId = id
        if let treasureId = self.treasureId {
            let treasure = TreasureRepository().findTreasureDetailWith(id: treasureId)
            self.edit = EditTreasureForm.init(with: treasure)
        }
    }
    
    convenience required init?(coder: NSCoder) {
        self.init(coder: coder)
    }
    
    // MARK: - Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigation()
       
    }

    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        imagesView.frame = CGRect.init(x: 0, y: UISizeConstants.top, width: self.view.width, height: AddImagesSubviewConstants.height)
        categoryView.frame = CGRect(x: 0, y: imagesView.bottom + 10, width: self.contentView.width, height: 44)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.frame = self.view.bounds
        self.view.addSubview(contentView)
        addImagesView()
        addCategoryView()
        
    }
    
    private func configNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        if self.edit.identifier != nil {
            self.title = "修改藏品"
        } else {
            self.title = "添加藏品"
        }
        self.navigationController?.navigationBar.tintColor = ColorConstants.titleColor
           
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "share"), style: UIBarButtonItem.Style.done, target: self, action: #selector(save))
       
    }
    
    // MARK: - Subviews
    private func addImagesView() {
        imagesView.images = self.edit.images
        imagesView.showAlbum = {(tag: Int) in
            self.showAlbum()
        }
        imagesView.showAlert = {(alert: UIAlertController) in
            self.present(alert, animated: true, completion: nil)
        }
        self.contentView.addSubview(imagesView)
    }

    private func addCategoryView() {
        
        categoryView.category = edit.category
        categoryView.tapAction = { () in
            self.popPicker()
        }
        self.contentView.addSubview(categoryView)
    }
    
    private func popPicker() {
        let shower = CategoryPickerShowFromBottom.init { (category) in
            self.updateCategory(category: category)
        }
        shower.show(in: self.tabBarController ?? self)
    }
   
    // MARK: - data
    private func updateCategory(category: Category) {
        self.edit.category = category
        self.categoryView.category = category
    }
    
    @objc private func save() {
        self.edit.images = imagesView.getImages()
        self.edit.saveOrUpdate()
    }
    
    @IBAction func testUI(_ sender: Any) {
        
    }
    

}

// MARK: - ImagePicker
extension EditController {
    private func showAlbum() {
           //判断设置是否支持图片库
           if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
               //初始化图片控制器
               let picker = UIImagePickerController()
               //设置代理
               picker.delegate = self
               //指定图片控制器类型
               picker.sourceType = UIImagePickerController.SourceType.photoLibrary
               //设置是否允许编辑
               picker.allowsEditing = true
               //弹出控制器，显示界面
               self.present(picker, animated: true, completion: {
                   () -> Void in
               })
           }else{
               print("读取相册错误")
           }
       }
   
    func imagePickerController(_ picker: UIImagePickerController,
       didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       //查看info对象
       print(info)
        
       //显示的图片
       let imageOpt = info[.editedImage] as? UIImage

       //图片控制器退出
       picker.dismiss(animated: true, completion: {
           () -> Void in
            if let image = imageOpt {
                self.imagesView.addImage(with: image)
            }
       })
   }
    
}

//
//  EditController.swift
//  Treasures
//
//  Created by joanfen on 2019/12/4.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class EditController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, InputViewDelegate {
    
    var treasureId: Int?
    var edit: EditTreasureForm = EditTreasureForm()
    
    // MARK: views
    private let contentView = UIScrollView()

    private let imagesView = AddImagesSubview.loadXib()
    private let categoryView = ChooseCategorySubview.loadXib()
    
    private let nameInputView = InputSubview.loadXib()
    private let sizeInputView = MultiInputView.loadXib()
    private let yearInputView = MultiInputView.loadXib()
    private let descriptionInputView = MultiInputView.loadXib()
    private let keywordInputView = MultiInputView.loadXib()
    
    private let purchasingTimeInputView = InputSubview.loadXib()
    private let purchasingPriceInputView = InputSubview.loadXib()
    private let sellingPriceInputView = InputSubview.loadXib()
    
    private let avaliableView = SwitchSubview.loadXib()
    private let soldView = SwitchSubview.loadXib()
    
    private let noteView = MultiInputView.loadXib()
    

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
        let singleHeight: CGFloat = 50;
        imagesView.frame = CGRect.init(x: 0, y: UISizeConstants.top, width: self.contentView.width, height: AddImagesSubviewConstants.height)
        categoryView.frame = CGRect(x: 0, y: imagesView.bottom + 10, width: self.contentView.width, height: singleHeight)
        nameInputView.frame = CGRect(x: 0, y: categoryView.bottom, width: self.contentView.width, height: singleHeight)
        sizeInputView.frame = CGRect(x: 0, y: nameInputView.bottom, width: self.contentView.width, height: 100)
        yearInputView.frame = CGRect(x: 0, y: sizeInputView.bottom, width: self.contentView.width, height: 100)
        descriptionInputView.frame = CGRect(x: 0, y: yearInputView.bottom, width: self.contentView.width, height: 140)
        keywordInputView.frame = CGRect(x: 0, y: descriptionInputView.bottom, width: self.contentView.width, height: 140)
        purchasingTimeInputView.frame = CGRect(x: 0, y: keywordInputView.bottom + 10, width: self.contentView.width, height: singleHeight)
        purchasingPriceInputView.frame = CGRect(x: 0, y: purchasingTimeInputView.bottom, width: self.contentView.width, height: singleHeight)
        sellingPriceInputView.frame = CGRect(x: 0, y: purchasingPriceInputView.bottom, width: self.contentView.width, height: singleHeight)
        avaliableView.frame = CGRect(x: 0, y: sellingPriceInputView.bottom, width: self.contentView.width, height: singleHeight)
        soldView.frame = CGRect(x: 0, y: avaliableView.bottom, width: self.contentView.width, height: singleHeight)
        
        noteView.frame = CGRect(x: 0, y: soldView.bottom + 10, width: self.contentView.width, height: singleHeight)
        contentView.contentSize = CGSize(width: self.view.width, height: noteView.bottom)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height - 65)
        
        self.view.addSubview(contentView)
        addImagesView()
        addCategoryView()
        addNameInputView()
        addSizeInputView()
        addYearInputView()
        addDescriptionView()
        addKeywordInputView()
        addPurchasedTimeView()
        addPurchasedPriceView()
        addSoldPriceView()
        addAvaliableView()
        addSoldView()
        
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
    
    private func addNameInputView() {
        nameInputView.dataSetting(title: "名称", value: self.edit.name, textChanged: { (name) in
            self.edit.name = name
        }, delegate: self)
        contentView.addSubview(nameInputView)
    }
    
    
    private func addSizeInputView() {
        sizeInputView.dataSetting(title: "尺寸", value: self.edit.size, textChanged: { (size) in
            self.edit.size = size
        })
        contentView.addSubview(sizeInputView)
    }
    
    private func addYearInputView() {
        yearInputView.dataSetting(title: "年份", value: self.edit.year) { (year) in
            self.edit.year = year
        }
        contentView.addSubview(yearInputView)
    }
    
    private func addDescriptionView() {
        descriptionInputView.dataSetting(title: "描述", value: self.edit.descrpiton) { (desc) in
            self.edit.descrpiton = desc
        }
        contentView.addSubview(descriptionInputView)
    }
    
    private func addKeywordInputView() {
        keywordInputView.dataSetting(title: "关键字", value: self.edit.keywords.joined(separator: ",")) { (keywords) in
            self.edit.keywords = keywords.components(separatedBy: ",")
          }
          contentView.addSubview(keywordInputView)
    }
   
    private func addPurchasedTimeView() {
        var yearString = ""
        if let year = self.edit.purchasedYear {
            yearString = String(year)
        }
        purchasingTimeInputView.dataSetting(title: "购入时间", value: yearString, textChanged: { (text) in
            self.edit.purchasedYear = Int(text)
        }, delegate: self)
        purchasingTimeInputView.showUnit(text: "年")
        contentView.addSubview(purchasingTimeInputView)
    }
    
    private func addPurchasedPriceView() {
        purchasingPriceInputView.dataSetting(title: "购入价格", value: String((self.edit.purchasedPrice ?? 0)), textChanged: { (text) in
            self.edit.purchasedPrice = Float(Int.init(text) ?? 0)
        }, delegate: self)
        purchasingPriceInputView.showUnit(text: "RMB")
        contentView.addSubview(purchasingPriceInputView)
    }
    private func addSoldPriceView() {
        sellingPriceInputView.dataSetting(title: "售出价格", value: String((self.edit.sellingPrice ?? 0)/100), textChanged: { (text) in
            self.edit.sellingPrice = Float(Int.init(text) ?? 0)
        }, delegate: self)
        sellingPriceInputView.showUnit(text: "RMB")
        contentView.addSubview(sellingPriceInputView)
    }
    
    private func addAvaliableView() {
        avaliableView.dataSetting(title: "是否可售", choosed: self.edit.available) { (chosed) in
            self.edit.available = chosed
        }
        contentView.addSubview(avaliableView)
    }
    private func addSoldView() {
        soldView.dataSetting(title: "是否已售", choosed: self.edit.isSold) { (chosed) in
            self.edit.isSold = chosed
        }
        contentView.addSubview(soldView)
    }
       
    private func addNoteView() {
        
    }
    
    
    // MARK: - data
    private func updateCategory(category: Category) {
        self.edit.category = category
        self.categoryView.category = category
    }
    
    @objc private func save() {
        nameInputView.resignFirstResponder()
        self.edit.images = imagesView.getImages()
        self.edit.saveOrUpdate()
    }
    
    @IBAction func testUI(_ sender: Any) {
        
    }
}

// MARK: - Input
extension EditController {
    func textFieldBeginEditing(at bottom: CGFloat) {
        
//        self.contentView.setContentOffset(CGPoint(x: 0, y: bottom + 20), animated: true)
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

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
    
    private let nameInputView = MultiInputView.loadXib()
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
    
    convenience init(withId id: Int?) {
        self.init()
        self.treasureId = id
        if let treasureId = self.treasureId {
            let treasure = TreasureRepository().findTreasureDetailWith(id: treasureId)
            self.edit = EditTreasureForm.init(with: treasure)
        }
    }
    
    convenience init(withId id: Int?, copy: Bool) {
        self.init(withId: id)
        if copy {
            self.treasureId = nil
            self.edit.identifier = nil
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
        // 图片
        imagesView.frame = CGRect.init(x: 0, y: 0, width: self.contentView.width, height: AddImagesSubviewConstants.height)
        // 类目
        categoryView.frame = CGRect(x: 0, y: imagesView.bottom + 10, width: self.contentView.width, height: singleHeight)
        // 名称
        nameInputView.frame = CGRect(x: 0, y: categoryView.bottom, width: self.contentView.width, height: 140)
        // 关键字
        keywordInputView.frame = CGRect(x: 0, y: nameInputView.bottom, width: self.contentView.width, height: 140)
        // 尺寸
        sizeInputView.frame = CGRect(x: 0, y: keywordInputView.bottom, width: self.contentView.width, height: 100)
        // 年份
        yearInputView.frame = CGRect(x: 0, y: sizeInputView.bottom, width: self.contentView.width, height: 100)
        // 描述
        descriptionInputView.frame = CGRect(x: 0, y: yearInputView.bottom, width: self.contentView.width, height: 140)
        // 购入时间
        purchasingTimeInputView.frame = CGRect(x: 0, y: descriptionInputView.bottom + 10, width: self.contentView.width, height: singleHeight)
        // 购入价格
        purchasingPriceInputView.frame = CGRect(x: 0, y: purchasingTimeInputView.bottom, width: self.contentView.width, height: singleHeight)
        // 出售状态
        avaliableView.frame = CGRect(x: 0, y: purchasingPriceInputView.bottom, width: self.contentView.width, height: singleHeight)
        // 出售价格
        sellingPriceInputView.frame = CGRect(x: 0, y: avaliableView.bottom, width: self.contentView.width, height: singleHeight)
        // 笔记
        noteView.frame = CGRect(x: 0, y: sellingPriceInputView.bottom + 10, width: self.contentView.width, height: 140)
        // TODO: 保存按钮
        contentView.contentSize = CGSize(width: self.view.width, height: noteView.bottom + 10 )
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height)
        
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
        addAvaliableView()
        addSoldPriceView()
        addNoteView()
        
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
        shower.show(in: self.tabBarController?.view ?? self.view)
    }
    
    private func addNameInputView() {
        nameInputView.dataSetting(title: "名称", value: self.edit.name, textChanged: { (name) in
            self.edit.name = name
        }, delegate: self)
        contentView.addSubview(nameInputView)
    }
    
    
    private func addSizeInputView() {
        sizeInputView.dataSetting(title: "尺寸", value:self.edit.size , textChanged: { (size) in
            self.edit.size = size
        }, delegate: self)
        contentView.addSubview(sizeInputView)
    }
    
    private func addYearInputView() {
        yearInputView.dataSetting(title: "年份", value: self.edit.year, textChanged: { (year) in
            self.edit.year = year
        }, delegate: self)
        contentView.addSubview(yearInputView)
    }
    
    private func addDescriptionView() {
        descriptionInputView.dataSetting(title: "描述", value: self.edit.descrpiton, textChanged: { (desc) in
            self.edit.descrpiton = desc
        }, delegate: self)
        contentView.addSubview(descriptionInputView)
    }
    
    private func addKeywordInputView() {
        keywordInputView.dataSetting(title: "关键字", value: self.edit.keywords.joined(separator: ","), textChanged: { (keywords) in
          self.edit.keywords = keywords.components(separatedBy: ",")
        }, delegate: self)
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
        contentView.addSubview(purchasingPriceInputView)
    }
    private func addSoldPriceView() {
        sellingPriceInputView.dataSetting(title: "出售价格", value: String((self.edit.sellingPrice ?? 0)/100), textChanged: { (text) in
            self.edit.sellingPrice = Float(Int.init(text) ?? 0)
        }, delegate: self)
        sellingPriceInputView.hideSeperateLine()
        contentView.addSubview(sellingPriceInputView)
    }
    
    private func addAvaliableView() {
        avaliableView.dataSetting(title: "出售状态", sellStatus: self.edit.sellStatus) { (sellStatus) in
            self.edit.sellStatus = sellStatus
        }
        contentView.addSubview(avaliableView)
    }
       
    private func addNoteView() {
        noteView.dataSetting(title: "备注", value:  self.edit.note, textChanged: { (note) in
            self.edit.note = note
        }, delegate: self)
        noteView.hideSeperateLine()
        contentView.addSubview(noteView)
    }
    
    
    // MARK: - data
    private func updateCategory(category: Category) {
        self.edit.category = category
        self.categoryView.category = category
    }
    
    @objc private func save() {
        // TODO: - 所有 input 都应该 退出编辑
//        nameInputView.resignFirstResponder()
        self.edit.images = imagesView.getImages()
        let result = self.edit.saveOrUpdate()
        if (result) {
            HUDHandler.showSuccess(with: "保存成功", in: self.view)
        } else {
            HUDHandler.showError(with: "保存失败", in: self.view)
        }
    }
    
}

// MARK: - Input
extension EditController {
    func textFieldBeginEditing(at bottom: CGFloat, inputView: InputBaseView) {
        if inputView == keywordInputView {
            let _ = keywordInputView.resignFirstResponder()
            let view = JFBubbleViewController.init(tags: self.edit.keywords, allTags: KeywordsRepo.queryKeywords())
        
            view?.saveKeywords = { (keywords) in
                self.edit.keywords = keywords ?? []
                self.keywordInputView.updateContent(content: keywords?.joined(separator: ","))
                let _ = self.keywordInputView.resignFirstResponder()
            }
            if let vc = view {
                self.present(vc, animated: true, completion: nil)
            }
        }
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

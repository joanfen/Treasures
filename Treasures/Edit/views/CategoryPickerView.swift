//
//  CategoryPickerView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/16.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

typealias SelectedCategory = (_ category: Category) -> Void

protocol CategoryPickerProtocol {
    func show(in view: UIView)
    func dismiss()
    func selected(category: Category)
}

class CategoryPickerShowFromBottom: CategoryPickerProtocol{
    private let bgView = UIView()
    private let picker = CategoryPickerView.loadXib()
    var placeHolderCategory: Category? = nil {
        didSet {
            if let category = placeHolderCategory {
                picker.locateCategory(category: category)
            }
        }
    }
    var selectedAction: SelectedCategory
    
    init(with selected: @escaping SelectedCategory) {
        self.selectedAction = selected
        picker.pickerDelegate = self
    }
    func dismiss() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        picker.setY(with: 10000)
        UIView.commitAnimations()
        self.bgView.removeFromSuperview()
    }
    
    func selected(category: Category) {
        self.selectedAction(category)
    }
    
    func show(in view: UIView) {
        bgView.backgroundColor = UIColor.clear

        bgView.frame = view.bounds
        view.addSubview(bgView)
        
        picker.frame = CGRect(x: 0, y: view.bottom, width: view.width, height: 304)
        view.addSubview(picker)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        bgView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        picker.setY(with: view.height - 304)
        
        UIView.commitAnimations()
        
    }
}




enum CategoryPickerComponent: Int{
    case first = 0
    case second = 1
    case count = 2
}

class CategoryPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var pickerView: UIPickerView!
    
    var selectedFirst: Int = 0
    var selectedSecond: Int = 0
    var categories: [CategoryDTO] = []
    var pickerDelegate: CategoryPickerProtocol?

    class func loadXib() -> CategoryPickerView {
        return Bundle.main.loadNibNamed("CategoryPickerView", owner: self, options: nil)!.first as! CategoryPickerView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.categories = CategoryRepo.queryMyCategories()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.reloadAllComponents()
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.pickerDelegate?.dismiss()
        
    }
    
    @IBAction func done(_ sender: Any) {
        self.pickerDelegate?.dismiss()
        selectedAction()
    }
    
    
    
    func locateCategory(category: Category) {
        for (index, value) in categories.enumerated() {
            if (value.firstId == category.firstCategory.id) {
                selectedFirst = index
                for(index2, value2) in value.secondCategories.enumerated() {
                    if (value2.secondId == category.secondCategory.id) {
                        selectedSecond = index2
                        return
                    }
                }
            }
        }
    }
    
    private func selectedAction() {
        let first = categories[selectedFirst]
        let second = first.secondCategories[selectedSecond]
        let selected = Category.init(firstCategory: CategoryInfo(id: first.firstId, name: first.name),
                      secondCategory: CategoryInfo(id: second.secondId, name: second.name))
        self.pickerDelegate?.selected(category: selected)
    }
}

extension CategoryPickerView {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return CategoryPickerComponent.count.rawValue
       }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       switch component {
       case CategoryPickerComponent.first.rawValue:
           return categories.count
       case CategoryPickerComponent.second.rawValue:
        if (categories.count > selectedFirst) {
            return categories[selectedFirst].secondCategories.count
        }
        return 0
       default:
           return 0
       }
    }
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       switch component {
       case CategoryPickerComponent.first.rawValue:
           return categories[row].name
       case CategoryPickerComponent.second.rawValue:
           return categories[selectedFirst].secondCategories[row].name
       default:
           return ""
       }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == CategoryPickerComponent.first.rawValue {
            selectedFirst = row
            pickerView.reloadComponent(CategoryPickerComponent.second.rawValue)
        } else {
            selectedSecond = row
        }
    }
    
    
}

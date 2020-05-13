//
//  CategoryFilterView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/26.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit
typealias SelectSecondCategory = (_ category: CategoryInfo?) -> Void

class CategoryPickerForFilter: CategoryPickerProtocol {
    var top: CGFloat = 0
    let height: CGFloat = 304
    private let bgView = UIView()
    private let picker = CategoryFilterView.loadXib()
    
    typealias Dismiss = (_ needSearch: Bool) -> Void
    var dismissAction: Dismiss?
    var selectCategoryAction: SelectSecondCategory?
    
    init(with top: CGFloat, category: CategoryInfo?) {
        self.top = top
        picker.selectCategory = category
        picker.pickerDelegate = self

    }
    
    func show(in view: UIView) {
        
        bgView.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        bgView.alpha = 0
        bgView.frame = CGRect(x: 0, y: self.top + 240, width: view.width, height: UISizeConstants.screenHeight - self.top)
        
        UIApplication.shared.keyWindow?.addSubview(bgView)
        picker.initData()
        picker.frame = CGRect(x: 0, y: top, width: view.width, height: 0)
        picker.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(picker)
        
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        picker.setHeight(with: 240)
        picker.alpha = 1
        bgView.alpha = 1
        UIView.commitAnimations()
    }
    
    func dismiss() {
        
        hidePicker()
        self.dismissAction?(true)
        
    }
    
    func hidePicker() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        picker.setHeight(with: 0)
        UIView.commitAnimations()
        picker.removeFromSuperview()
        bgView.removeFromSuperview()
    }
    
    func selected(category: Category) {
        hidePicker()
        self.dismissAction?(false)
        self.selectCategoryAction?(CategoryInfo(id: category.secondCategory.id, name: category.secondCategory.name))
        
    }
    
    
    
}
class CategoryFilterView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    var categories: [SecondCategoryDTO] = []
    var selectedIndex = 0
    var selectCategory: CategoryInfo? {
        didSet {
            self.locateCategory(category: selectCategory)
        }
    }
    var pickerDelegate: CategoryPickerProtocol?
    class func loadXib() -> CategoryFilterView {
        return Bundle.main.loadNibNamed("CategoryFilterView", owner: self, options: nil)!.first as! CategoryFilterView
    }
    
    func locateCategory(category: CategoryInfo?) {
        if let c = category {
            for (index, value) in categories.enumerated() {
                if (value.secondId == c.id) {
                    selectedIndex = index
                    break
                }
            }
        } else {
            selectedIndex = 0
        }
        self.picker.selectRow(selectedIndex, inComponent: 0, animated: false)
        
    }
    
    override func awakeFromNib() {
        superview?.awakeFromNib()
        
        categories = CategoryRepo.queryMyCategories().flatMap { (dto) -> [SecondCategoryDTO] in
            return dto.secondCategories
        }
        
    }
    
    func initData() {
        categories = CategoryRepo.queryMyCategories().flatMap { (dto) -> [SecondCategoryDTO] in
        return dto.secondCategories
        }
        self.picker.reloadAllComponents()
        self.picker.selectRow(selectedIndex, inComponent: 0, animated: false)
    }
    
    @IBAction func cancel(_ sender: Any) {
        pickerDelegate?.dismiss()
    }
    
    @IBAction func done(_ sender: Any) {
        if (self.selectedIndex >= categories.count) {
            pickerDelegate?.dismiss()
            return
        }
        let c = categories[self.selectedIndex]
        let selected = CategoryInfo(id: c.secondId, name: c.name)
        selectCategory = selected
        let fir = CategoryInfo(id: c.parentId, name: c.name)
        pickerDelegate?.selected(category: Category(firstCategory: fir, secondCategory: selected))
    }
}

extension CategoryFilterView {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
       }
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.categories.count
    }
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }
    
    
}

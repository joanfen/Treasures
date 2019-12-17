//
//  CategoryPickerView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/16.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit
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
    typealias SelectedCategory = (_ category: Category) -> Void
    var selectedCategory: SelectedCategory?

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
        
    }
    
    @IBAction func done(_ sender: Any) {
        selectedAction()
    }
    
    private func selectedAction() {
        let first = categories[selectedFirst]
        let second = first.secondCategories[selectedSecond]
        let selected = Category.init(firstCategory: CategoryInfo(id: first.firstId, name: first.name),
                      secondCategory: CategoryInfo(id: second.secondId, name: second.name))
        self.selectedCategory?(selected)
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
           return categories[selectedFirst].secondCategories.count
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

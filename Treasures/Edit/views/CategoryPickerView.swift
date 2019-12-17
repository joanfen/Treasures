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
    private var pickerView: UIPickerView = UIPickerView()
    var selectedFirst: Int = 0
    var selectedSecond: Int = 0
    var categories: [CategoryDTO] = []
    

    init(category: [CategoryDTO]) {
        super.init(frame: CGRect.zero)
        self.categories = CategoryRepo.queryMyCategories()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
       
    }
   
    required init?(coder: NSCoder) {
       super.init(coder: coder)
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
            self.pickerView.reloadComponent(component)
        } else {
            selectedSecond = row
        }
    }
}

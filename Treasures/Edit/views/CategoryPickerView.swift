//
//  CategoryPickerView.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/16.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class CategoryPickerView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories[component].secondCategories.count
    }
    

    private var pickerView: UIPickerView = UIPickerView()
    var categories: [CategoryDTO] = []
    
    
//    init(category: [CategoryDTO]) {
//        
//        self.categories = category
//        self.pickerView.delegate = self
//        self.pickerView.dataSource = self
//
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    

}

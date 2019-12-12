//
//  EditController.swift
//  Treasures
//
//  Created by joanfen on 2019/12/4.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class EditController: UIViewController {
    let imagesView = AddImagesSubview.loadXib()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(imagesView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigation()
    }

    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        imagesView.frame = CGRect.init(x: 0, y: UISizeConstants.top, width: self.view.width, height: AddImagesSubviewConstants.height)
    }

    private func configNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        self.title = "修改藏品"
        self.navigationController?.navigationBar.tintColor = ColorConstants.titleColor
    }

}

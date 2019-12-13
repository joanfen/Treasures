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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(imagesView)
        self.edit.saveOrUpdate()
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

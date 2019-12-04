//
//  TreasureEditCellInterface.swift
//  Treasures
//
//  Created by joanfen on 2019/11/29.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import UIKit
class TreasureBaseCell: UITableViewCell {
    
    
}
class Model: Any {
    open var dataSource: TreasureEditCellProtocol
    init(source: TreasureEditCellProtocol) {
        self.dataSource = source
    }
    
    func configCellAndReturn() -> UITableViewCell {
        return dataSource.configCell()
    }
    func contentHeight() -> CGFloat {
        return dataSource.contentHeight()
    }
    
    
    
}

protocol TreasureEditCellProtocol {
    func configCell() -> UITableViewCell
    func contentHeight() -> CGFloat
    
}

class CellImplementClass: TreasureEditCellProtocol {
    func contentHeight() -> CGFloat {
        return 0
    }
    

    private var treasureEditCell: TreasureBaseCell;
    final let cellIdentifier = "imageCell"
    
    init() {
        self.treasureEditCell = TreasureBaseCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellIdentifier)
    }
    
    func configCell() -> UITableViewCell {
        return self.treasureEditCell
    }
    
    
}

class TreasureEditView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableview = UITableView(frame: view.bounds)
        
        tableview.dataSource = self;
        tableview.delegate = self;
        
    }
    
}
extension TreasureEditView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let model = Model.init(source: CellImplementClass.init())
        
        let source = CellImplementClass.init()
        return source.configCell()
    }
    
    
}

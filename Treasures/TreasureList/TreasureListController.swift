//
//  TreasureListController.swift
//  Treasures
//
//  Created by joanfen on 2019/12/4.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit
import Foundation

protocol TreasureListUpdateProtocol {
    func searchBegin()
}

class TreasureListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var addButton: UIButton!

    var searchBarView: SearchBarView = SearchBarView.loadXib()
    var filterView: ListFilterView = ListFilterView.loadXib()
    var tableView: UITableView = UITableView()
    
    var treasureList: [TreasureCellVO] = []
    var searchHandler: TreasureSearchHandler = TreasureSearchHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigation()
        tableViewSetting()
        addSubviews()
        
    }
    
    private func configNavigation() {
           self.navigationController?.navigationBar.isHidden = true
    }
    
    private func tableViewSetting() {
        let y = filterView.bottom + 10
        tableView.frame = CGRect.init(x: 0, y: y, width: self.view.width, height: self.view.bottom - y)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = TreasureListCellConstants.height
        self.view.addSubview(tableView)
    }
    
   
    
    private func addSubviews() {
        self.view.addSubview(searchBarView)
        filterView.filterBegin = { (filter: FilterPreference) in
            self.treasureList = self.searchHandler.search(filter: filter)
            self.tableView.reloadData()
        }
        self.view.addSubview(filterView)
        
        self.view.bringSubviewToFront(self.addButton)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addTreasure(_ sender: Any) {
        self.navigationController?.pushViewController(EditController(), animated: true)
    }
}


extension TreasureListController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
       
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TreasureListCellConstants.reuseId) ?? TreasureListCell.loadXib()
    
    return cell
   }
       
}

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
    var filterPreference = FilterPreference()
    var refreshControl = UIRefreshControl()
    var actionPopView: EditPopView = EditPopView.loadXib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.filterPreference = filterPreference
        tableViewSetting()
        addSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigation()
        initialSearch()
    }
    
    private func searchBegin() {
        self.treasureList.append(contentsOf: self.searchHandler.search(filter: filterPreference))
        self.tableView.reloadData()
    }
    
    private func configNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func tableViewSetting() {
        let y = filterView.bottom + 10
        tableView.register(TreasureListCellConstants.nib(), forCellReuseIdentifier: TreasureListCellConstants.reuseId)
        tableView.tableFooterView = UIView()
        tableView.frame = CGRect.init(x: 0, y: y, width: self.view.width, height: self.view.bottom - y)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = TreasureListCellConstants.height
        self.view.addSubview(tableView)
    }
    
    private func refreshSetting() {
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新...")
        refreshControl.addTarget(self, action: #selector(loadNextPage), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func loadNextPage(sender: Any) {
        
        filterPreference.currentPage += 1
        searchBegin()
        refreshControl.endRefreshing()
        
    }
    
    private func initialSearch() {
        self.treasureList.removeAll()
        searchBegin()
    }
   
    
    private func addSubviews() {
        self.view.addSubview(searchBarView)
        filterView.filterBegin = { (filter: FilterPreference) in
            
            self.initialSearch()
        }
        self.view.addSubview(filterView)
        
        self.view.bringSubviewToFront(self.addButton)
    }

    @IBAction func addTreasure(_ sender: Any) {
//        self.navigationController?.pushViewController(EditController(), animated: true)
        self.view.addSubview(actionPopView)
        actionPopView.ActionBlock = {[weak self] (action:PopAction) in
            guard let weakSelf = self else {return}
            switch action {
            case .edit:
                print("edit")
            case .delete:
                print("delete")
            default:
                print("copy")
            }
        }
    }
}


extension TreasureListController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.treasureList.count
    }
       
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TreasureListCell = tableView.dequeueReusableCell(withIdentifier: TreasureListCellConstants.reuseId) as! TreasureListCell
        cell.config(with: self.treasureList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(EditController.init(withId: self.treasureList[indexPath.row].id), animated: true)
    }
}

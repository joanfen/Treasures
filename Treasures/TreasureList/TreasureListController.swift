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
   
    // MARK:  - View
    @IBOutlet weak var placeholderView: UIView!
    @IBOutlet weak var placeholderLbl: UILabel!
    @IBOutlet weak var addButton: UIButton!

    var searchBarView: SearchBarView = SearchBarView.loadXib()
    var filterView: ListFilterView = ListFilterView.loadXib()
    var tableView: UITableView = UITableView()
    var actionPopView: EditPopView = EditPopView.loadXib()

    // MARK: - Data
    var treasureList: [TreasureCellVO] = []
    var searchHandler: TreasureSearchHandler = TreasureSearchHandler()
    var filterPreference = FilterPreference()

    // MARK: - Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.filterPreference = filterPreference
        tableViewSetting()
        addSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        configNavigation()
        initialSearch()
        reloadPlaceHolder()
    }
    
    private func reloadPlaceHolder() {
        if self.treasureList.count != 0 {
            self.placeholderView.isHidden = true
            return
        }
        self.view.bringSubviewToFront(self.placeholderView)
        self.placeholderView.isHidden = false
        let categorys = CategoryRepo.queryMyCategories()
        var tips = "暂无数据\n请在分类界面添加分类"
        if categorys.count != 0 {
            tips = "暂无数据\n请点击加号添加藏品"
        }
        self.placeholderLbl.text = tips
    }
    
    private func configNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.searchBarView.frame = CGRect.init(x: 0, y: 0, width: UISizeConstants.screenWidth, height: 82)
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
    
    private func addSubviews() {
        self.view.addSubview(searchBarView)
        searchBarView.searchBegin = { (text: String?) in
            if let searchText = text {
                self.filterPreference.searchText = searchText
                self.initialSearch()
            }
        }
        filterView.filterBegin = { (filter: FilterPreference) in
            self.initialSearch()
        }
        self.view.addSubview(filterView)
        
        self.view.bringSubviewToFront(self.addButton)
    }
    
    private func initialSearch() {
        self.treasureList.removeAll()
        searchBegin()
    }
    
    private func searchBegin() {
        self.treasureList.append(contentsOf: self.searchHandler.search(filter: filterPreference))
        self.tableView.reloadData()
    }
    
    
    // MARK: - View 跳转
    @IBAction func addTreasure(_ sender: Any) {
        newTreasure()
    }
    
    
    private func newTreasure() {
        toEditView(treasureId: nil, copy: false)
    }
    
    private func editTreasure(id: Int) {
        toEditView(treasureId: id, copy: false)
    }
    
    private func copyTreasure(id: Int) {
        toEditView(treasureId: id, copy: true)
    }
    
    private func toEditView(treasureId: Int?, copy: Bool) {
        let edit = EditController.init(withId: treasureId, copy: copy)
        edit.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(edit, animated: true)
        edit.hidesBottomBarWhenPushed = false
    }
    
    private func toDetailView(id: Int) {
        // TODO: - 详情页跳转
    }
    
    func showActionPopView(treasureId: Int) {
        self.view.addSubview(actionPopView)
        actionPopView.ActionBlock = {[weak self] (action:PopAction) in
            guard let weakSelf = self else {return}
            switch action {
            case .edit:
                weakSelf.editTreasure(id: treasureId)
            case .delete:
                print("delete")
            default:
                weakSelf.copyTreasure(id: treasureId)
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
        let source = self.treasureList[indexPath.row]
        cell.config(with: source, actionBlock: { (hud, collected) in
            hud.show(in: self.view)
            let source = self.treasureList[indexPath.row]
            source.isCollected = collected
        }, longPressAction: {() in
            self.showActionPopView(treasureId: source.id)
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        toDetailView(id: self.treasureList[indexPath.row].id)
    }
    
    
}

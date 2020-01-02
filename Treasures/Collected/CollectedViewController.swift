//
//  CollectedViewController.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/18.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class CollectedViewController: UIViewController {
    var dataSource = [TreasureCellVO]()
    
    @IBOutlet weak var emptyLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initData()
    }

    @IBAction func popClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUI() {
    
        tableView.register(TreasureListCellConstants.nib(), forCellReuseIdentifier: TreasureListCellConstants.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = TreasureListCellConstants.height
        self.view.addSubview(tableView)
    }
    
    private func pushToDetail(treasureId: Int) {
        let detailVC = TreasureDetailVC()
        detailVC.tId = treasureId
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func initData() {
        dataSource = TreasureRepository.findCollectedTreasures()
        self.tableView.isHidden = dataSource.count == 0
        self.tableView.reloadData()
    }
}

extension CollectedViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TreasureListCellConstants.reuseId) as! TreasureListCell
        cell.config(with: self.dataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let treasure = self.dataSource[indexPath.row]
        self.pushToDetail(treasureId: treasure.id)
    }
}

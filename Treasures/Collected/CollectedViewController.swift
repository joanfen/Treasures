//
//  CollectedViewController.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/18.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class CollectedViewController: UIViewController {
    var dataSource = [TreasureListSearchDTO]()
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
    
    func setUI() {
    
        tableView.register(TreasureListCellConstants.nib(), forCellReuseIdentifier: TreasureListCellConstants.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = TreasureListCellConstants.height
        self.view.addSubview(tableView)
    }
    
    func initData() {
        dataSource = TreasureRepository.findCollectedTreasures()
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
}

//
//  RecycleViewController.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/18.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class RecycleViewController: UIViewController {
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
    
    @IBAction func deleteBtnClicked(_ sender: Any) {
        if dataSource.count == 0 {
            showSuccess()
            return
        }
        let alert = UIAlertController.init(title: "提示", message: "是否确认清空", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "确定", style: .default) { (alert) in            
            if TreasureRepository.clearTrash() {
                self.showSuccess()
                self.initData()
            }
        }
        let cancel = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    private func showSuccess() {
        let hud = JGProgressHUD.init(style: .extraLight)
        hud.textLabel.text = "已清空"
        hud.indicatorView = JGProgressHUDSuccessIndicatorView.init()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1)
    }
    
    private func pushToDetail(treasureId: Int) {
        let detailVC = TreasureDetailVC()
        detailVC.tId = treasureId
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func setUI() {
        
        tableView.register(TreasureListCellConstants.nib(), forCellReuseIdentifier: TreasureListCellConstants.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = TreasureListCellConstants.height
        self.view.addSubview(tableView)
    }
    
    func initData() {
        dataSource = TreasureRepository.findDeletedTreasures()
        self.tableView.isHidden = dataSource.count == 0
        self.tableView.reloadData()
    }
}

extension RecycleViewController:UITableViewDelegate,UITableViewDataSource {
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

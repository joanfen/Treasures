//
//  CategoryViewController.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/16.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var bigTableView: UITableView!
    @IBOutlet weak var smallTableView: UITableView!
    var bigCategoryArr:[FirstCategoryTable] = []
    var smallCategoryArr:[SecondCategoryTable] = []
//    var myCategoryArr:[]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavigation()
        self.initData()
        self.setUI()
        // Do any additional setup after loading the view.
    }
    
    private func configNavigation() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func initData() {
        bigCategoryArr = CategoryRepo.queryFirstCategories()
        let firstId = bigCategoryArr[0].identifier ?? 0
        smallCategoryArr = CategoryRepo.querySecondCategories(parentId: firstId)
    }
    
    func setUI() {
        self.bigTableView.register(UINib.init(nibName: "BigCategoryCell", bundle: nil), forCellReuseIdentifier: "BigCategoryCell")
        self.smallTableView.register(UINib.init(nibName: "SmallCategoryCell", bundle: nil), forCellReuseIdentifier: "SmallCategoryCell")
        self.bigTableView.reloadData()
        self.smallTableView.reloadData()
        self.bigTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CategoryViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == bigTableView {
            return bigCategoryArr.count
        }
        return smallCategoryArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == bigTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BigCategoryCell") as! BigCategoryCell
            cell.titleLbl.text = bigCategoryArr[indexPath.row].name
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SmallCategoryCell") as! SmallCategoryCell
        cell.titleLbl.text = smallCategoryArr[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == bigTableView {
            let bigCategory = self.bigCategoryArr[indexPath.row]
            smallCategoryArr = CategoryRepo.querySecondCategories(parentId: bigCategory.identifier ?? 0)
            self.smallTableView.reloadData()
        }
    }
}

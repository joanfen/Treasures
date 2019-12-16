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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI() {
        self.bigTableView.register(UINib.init(nibName: "BigCategoryCell", bundle: nil), forCellReuseIdentifier: "BigCategoryCell")
        self.smallTableView.register(UINib.init(nibName: "SmallCategoryCell", bundle: nil), forCellReuseIdentifier: "SmallCategoryCell")
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == bigTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BigCategoryCell") as! BigCategoryCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "SmallCategoryCell") as! SmallCategoryCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

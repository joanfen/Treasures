//
//  PersonalViewController.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/15.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class PersonalViewController: UIViewController {
    
    @IBOutlet weak var nickNameLbl: UILabel!
    @IBOutlet weak var avatarBgView: UIView!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    let titleArr = ["邀请码","添加密码","我的收藏","回收站"]
    let imageArr = ["Invitation","password-1","My collection","bin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        // Do any additional setup after loading the view.
    }

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.avatarImg.layer.cornerRadius = 35
        self.avatarBgView.layer.cornerRadius = 39
        self.tableView.register(UINib.init(nibName: "PersonalCell", bundle: nil), forCellReuseIdentifier: "PersonalCell")
    }
    
    func toEditPW()  {
        let editPW = EditPasswordVC()
        editPW.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(editPW, animated: true)
    }
}
extension PersonalViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalCell") as! PersonalCell
        cell.reload(image: UIImage.init(named: imageArr[indexPath.row]), titleArr[indexPath.row], indexPath.row==0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            self.toEditPW()
        }
    }
}

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
    var nickName = "nickname"
    let titleArr = ["邀请码","添加密码","我的收藏","回收站"]
    let imageArr = ["Invitation","password-1","My collection","bin"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nickName = (UserDefaults.standard.object(forKey: "nickname") as? String) ?? "nickname"
        self.nickNameLbl.text = nickName
    }
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.avatarImg.layer.cornerRadius = 35
        self.avatarBgView.layer.cornerRadius = 39
        self.avatarImg.isUserInteractionEnabled = true
        let imgTap = UITapGestureRecognizer.init(target: self, action: #selector(self.setPhoto))
        self.avatarImg.addGestureRecognizer(imgTap)
        let nameTap = UITapGestureRecognizer.init(target: self, action: #selector(self.editNickName))
        self.nickNameLbl.isUserInteractionEnabled = true
        self.nickNameLbl.addGestureRecognizer(nameTap)
        self.tableView.register(UINib.init(nibName: "PersonalCell", bundle: nil), forCellReuseIdentifier: "PersonalCell")
    }
    
    func toEditPW()  {
        let editPW = EditPasswordVC()
        editPW.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(editPW, animated: true)
    }
    
    func toInvateVC() {
        let editPW = InvateViewController()
        editPW.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(editPW, animated: true)
    }
    
    func toCollectedVC() {
        let editPW = CollectedViewController()
        editPW.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(editPW, animated: true)
    }
    
    func toRecyleVC() {
        let editPW = RecycleViewController()
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
        switch indexPath.row {
        case 0:
            self.toInvateVC()
        case 1:
            self.toEditPW()
        case 2:
            self.toCollectedVC()
        default:
            self.toRecyleVC()
        }
    }
    @objc func editNickName () {
        var inputText:UITextField = UITextField()
        let alert = UIAlertController.init(title: "提示", message: "请输入用户名", preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "确定", style: .default) { (alert) in
            if let name = inputText.text {
                UserDefaults.standard.set(name, forKey: "nickname")
                UserDefaults.standard.synchronize()
                self.nickNameLbl.text = name
            }
        }
        let cancel = UIAlertAction.init(title: "取消", style: .cancel) { (action) in
            
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        alert.addTextField { (textField) in
            inputText = textField
            inputText.placeholder = "用户名"
        }
        self.present(alert, animated: true, completion: nil)
    }
}


extension PersonalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func setPhoto() {
        let alertController=UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancel=UIAlertAction(title:"取消", style: .cancel, handler: nil)
        let takingPictures=UIAlertAction(title:"拍照", style: .default)
        {
            action in
            self.goCamera()
            
        }
        let localPhoto=UIAlertAction(title:"本地图片", style: .default)
        {
            action in
            self.goImage()
            
        }
        alertController.addAction(cancel)
        alertController.addAction(takingPictures)
        alertController.addAction(localPhoto)
        self.present(alertController, animated:true, completion:nil)
    }
    
    func goCamera(){
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let  cameraPicker = UIImagePickerController()
            cameraPicker.delegate = self
            cameraPicker.allowsEditing = true
            cameraPicker.sourceType = .camera
            //在需要的地方present出来
            self.present(cameraPicker, animated: true, completion: nil)
        } else {
            
            print("不支持拍照")
            
        }
        
    }
    
    func goImage(){
        
        
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        //在需要的地方present出来
        self.present(photoPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        print("获得照片============= \(info)")
        
        let image : UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        //显示设置的照片
        avatarImg.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

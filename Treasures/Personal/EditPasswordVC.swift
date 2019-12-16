//
//  EditPasswordVC.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/15.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class EditPasswordVC: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var title = "添加密码"
        if let pw = UserDefaults.standard.object(forKey: "password") as? String{
            if !pw.isEmpty {
                title = "修改密码"
            }
        }
        self.titleLbl.text = title
    }
    
    func setUI() {
        var placeholder = NSMutableAttributedString.init(string: "密码", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        pwTF.attributedPlaceholder = placeholder
        placeholder = NSMutableAttributedString.init(string: "确认密码", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        confirmTF.attributedPlaceholder = placeholder
    }
    
    @IBAction func popClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnClicked() {
        if pwTF.text == confirmTF.text {
            let hud = JGProgressHUD.init(style: .extraLight)
            hud.textLabel.text = "保存成功"
            hud.indicatorView = JGProgressHUDSuccessIndicatorView.init()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 1)
            UserDefaults.standard.setValue(pwTF.text, forKey: "password")
            UserDefaults.standard.synchronize()
            delay(delay: 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }else {
            let hud = JGProgressHUD.init(style: .extraLight)
            hud.textLabel.text = "两次密码不一致"
            hud.indicatorView = JGProgressHUDErrorIndicatorView.init()
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 1)
        }
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

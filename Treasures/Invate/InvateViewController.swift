//
//  InvateViewController.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/18.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class InvateViewController: UIViewController {

    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var myKeyLbl: UILabel!
    @IBOutlet weak var inviteTF_1: UITextField!
    @IBOutlet weak var inviteTF_2: UITextField!
    @IBOutlet weak var inviteTF_3: UITextField!
    @IBOutlet weak var success_1: UIImageView!
    @IBOutlet weak var success_3: UIImageView!
    @IBOutlet weak var success_2: UIImageView!
    var myKey:String = ""
    var inviteKeys:Array<String> = ["","",""]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildMyKey()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadUI()
    }
    private func buildMyKey() {
        if let myKey = UserDefaults.standard.object(forKey: "myKey") as? String {
            self.myKey = myKey
        }
        if self.myKey.isEmpty {
            let dateStr = DateTimeUtil.format(time: Date(), formatText: "yyyyMMddHH") + (arc4random()%10).description
            if let dateLong = CLong(dateStr) {
                let key = InviteCodeUtils.encode(by: dateLong)
                self.myKey = key
                UserDefaults.standard.set(key, forKey: "myKey")
                UserDefaults.standard.synchronize()
            }
        }
        if let inviteKeys = UserDefaults.standard.object(forKey: "inviteKeys") as? Array<String> {
            self.inviteKeys = inviteKeys
        }else {
            UserDefaults.standard.set(self.inviteKeys, forKey: "inviteKeys")
            UserDefaults.standard.synchronize()
        }
    }
    
    private func checkInviteKey(key:String, index:Int) {
        if key == self.myKey {
            self.showError(error: "不能自己输入自己的邀请码")
            return
        }
        let decode = InviteCodeUtils.decode(by: key).description
        let endIndex = decode.index(decode.endIndex, offsetBy: -1)
        let dateStr = decode[decode.startIndex ..< endIndex]
        let date = DateTimeUtil.parse(text: String(dateStr), format: "yyyyMMddHH")
        if DateTimeUtil.dayDistance(time: date) <= 1 {
            self.showSuccess()
            self.inviteKeys[index] = key
            self.reloadUI()
            UserDefaults.standard.set(self.inviteKeys, forKey: "inviteKeys")
            UserDefaults.standard.synchronize()
        }else {
            self.showError(error: "邀请码或已超过24小时")
        }
    }
    
    private func reloadUI() {
        self.myKeyLbl.text = self.myKey
        self.inviteTF_1.text = self.inviteKeys[0]
        self.inviteTF_2.text = self.inviteKeys[1]
        self.inviteTF_3.text = self.inviteKeys[2]
        self.inviteTF_1.isEnabled = self.inviteKeys[0].isEmpty
        self.inviteTF_2.isEnabled = self.inviteKeys[1].isEmpty
        self.inviteTF_3.isEnabled = self.inviteKeys[2].isEmpty
        self.success_1.isHidden = self.inviteKeys[0].isEmpty
        self.success_2.isHidden = self.inviteKeys[1].isEmpty
        self.success_3.isHidden = self.inviteKeys[2].isEmpty
        
        self.copyBtn.layer.masksToBounds = true
        self.copyBtn.layer.cornerRadius = 15
        self.copyBtn.layer.borderWidth = 0.5
        self.copyBtn.layer.borderColor = UIColor.colorWithHexString(hex: "323232").cgColor
    }
    
    private func showSuccess() {
        let hud = JGProgressHUD.init(style: .extraLight)
        hud.textLabel.text = "邀请成功"
        hud.indicatorView = JGProgressHUDSuccessIndicatorView.init()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1)
    }
    
    private func showError(error:String) {
        let hud = JGProgressHUD.init(style: .extraLight)
        hud.textLabel.text = error
        hud.indicatorView = JGProgressHUDErrorIndicatorView.init()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1)
    }
    
    @IBAction func popClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func copyBtnClicked(_ sender: Any) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.myKey
        let hud = JGProgressHUD.init(style: .extraLight)
        hud.textLabel.text = "复制成功"
        hud.indicatorView = JGProgressHUDSuccessIndicatorView.init()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1)
    }
    
}

extension InvateViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let key = textField.text {
            if textField == inviteTF_1 {
                self.checkInviteKey(key: key, index: 0)
            }else if textField == inviteTF_2 {
                self.checkInviteKey(key: key, index: 1)
            }else {
                self.checkInviteKey(key: key, index: 2)
            }
        }
        return true
    }
}

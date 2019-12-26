//
//  ViewController.swift
//  Treasures
//
//  Created by joanfen on 2019/12/4.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    var pw = ""
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
            
    private func changeRootVC() {
        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
        UIApplication.shared.keyWindow?.rootViewController = rootVC
    }
    
    private func showSplash() {
        let showSplash = UserDefaults.standard.bool(forKey: "showSplash")
        if showSplash {return}
        guard let window = UIApplication.shared.keyWindow else {return}
        let imageView = UIImageView()
        imageView.frame = window.bounds
        imageView.sd_setImage(with: URL(string: "http://www.scgj.de/start.jpg"), placeholderImage: UIImage.init(named: "bg"), options: .highPriority, context: nil)
        window.addSubview(imageView)
        UserDefaults.standard.set(true, forKey: "showSplash")
        UserDefaults.standard.synchronize()
        delay(delay: 2) {
            imageView.removeFromSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showSplash()
       if let pw = UserDefaults.standard.object(forKey: "password") as? String {
           if pw.isEmpty {
               changeRootVC()
           }
           self.pw = pw
       }else {
           changeRootVC()
       }
    }
    @IBAction func login(_ sender: Any) {
        guard let password = self.passwordTF.text else {
            self.showError(str: "请输入密码")
            return
        }
        if password.isEmpty {
            self.showError(str: "请输入密码")
            return
        }
        if password != pw {
            self.showError(str: "密码错误")
            return
        }
        changeRootVC()
        
    }
    
    private func showError(str:String) {
        let hud = JGProgressHUD.init(style: .extraLight)
        hud.textLabel.text = str
        hud.indicatorView = JGProgressHUDErrorIndicatorView.init()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1)
    }
    
}


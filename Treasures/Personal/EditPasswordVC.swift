//
//  EditPasswordVC.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/15.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class EditPasswordVC: UIViewController {

    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

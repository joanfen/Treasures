//
//  InvateViewController.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/18.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class InvateViewController: UIViewController {

    @IBOutlet weak var myKeyLbl: UILabel!
    @IBOutlet weak var inviteTF_1: UITextField!
    @IBOutlet weak var inviteTF_2: UITextField!
    @IBOutlet weak var inviteTF_3: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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

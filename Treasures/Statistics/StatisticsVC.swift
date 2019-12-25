//
//  StatisticsVC.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/26.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class StatisticsVC: UIViewController {
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var saleTotalLbl: UILabel!
    @IBOutlet weak var buyTotalLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let count = TreasureRepository.getDataStatistic()
        self.countLbl.text = count.treasureCount.description
        self.saleTotalLbl.text = count.soldTotalFee.description
        self.buyTotalLbl.text = count.purchasedTotalFee.description
        // Do any additional setup after loading the view.
    }

    @IBAction func backBtnClicked() {
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

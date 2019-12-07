//
//  TreasureListController.swift
//  Treasures
//
//  Created by joanfen on 2019/12/4.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit
import Foundation
class TreasureListController: UIViewController {

    var searchBarView: SearchBarView = SearchBarView.loadXib()
    var filterView: ListFilterView = ListFilterView.loadXib()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(searchBarView)
        
        self.view.addSubview(filterView)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addTreasure(_ sender: Any) {
        self.navigationController?.pushViewController(EditController(), animated: true)
    }
}

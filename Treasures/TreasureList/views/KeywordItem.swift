//
//  KeywordItem.swift
//  Treasures
//
//  Created by joanfen on 2019/12/27.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

typealias SelectedKeyword = (_ keyword: String?) -> Void
typealias Cancel = () -> Void
class KeywordItem: UIView {

    @IBOutlet weak var highlightBar: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imgView: UIImageView!
    
    private var keyword: String?
    private var selected: Bool = false
    private var keywordFilter: KeywordFilterShower?

    var selectedAction: SelectedKeyword?
    var cancelAction: Cancel?
   
    class func loadXib() -> KeywordItem {
        return Bundle.main.loadNibNamed("KeywordItem", owner: self, options: nil)!.first as! KeywordItem
    }
    // filter -> item -> show
    // show -> cancel -> item 更新 UI
    // show -> select -> item 更新 UI -> filter
    
    override func awakeFromNib() {
        super.awakeFromNib()
        keywordFilter = KeywordFilterShower.init(selected: { (keyword) in
            self.selectedKeyword(keyword: keyword)
        }, cancel: { () in
            self.cancel()
        })
    }
    
    @IBAction func selectItem() {
        selected = !selected
        UIRefresh()
        popOrDismissFilter()
    }
    
    private func popOrDismissFilter() {
        if selected {
            keywordFilter?.show()
        } else {
            keywordFilter?.dismiss()
        }
    }
    
    private func UIRefresh() {
        highlightBar.isHidden = self.keyword == nil
        rotateArrow()
    }
    
    private func rotateArrow() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        self.imgView.transform = self.imgView.transform.rotated(by: CGFloat(-Double.pi))
        self.imgView.image = selected ? ImageConstants.downHiglight : ImageConstants.downNormal
        UIView.commitAnimations()
    }
    
    private func selectedKeyword(keyword: String?) {
        self.keyword = keyword
        selected = false
        UIRefresh()
        self.selectedAction?(keyword)
    }
    
    private func cancel() {
        selected = false
        UIRefresh()
        self.cancelAction?()
    }
    
}



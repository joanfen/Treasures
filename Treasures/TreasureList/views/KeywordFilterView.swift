//
//  KeywordFilterView.swift
//  Treasures
//
//  Created by joanfen on 2019/12/27.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit


class KeywordFilterShower {
    var selectedAction: SelectedKeyword?
    var cancelAction: Cancel?
    var bgView = UIView()
    var filterView = KeywordFilterView.loadXib()
    
    init(selected: SelectedKeyword?, cancel: Cancel?) {
        self.selectedAction = selected
        self.cancelAction = cancel
        filterView.selectedAction = { (keyword) in
            self.dismiss()
            self.selectedAction?(keyword)
        }
        filterView.cancelAction = {() in
            self.dismiss()
            self.cancelAction?()
        }
        
    }
    
    func show() {
        bgView.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        bgView.alpha = 0
        bgView.frame = CGRect(x: 0, y: 200, width: UISizeConstants.screenWidth, height: UISizeConstants.screenHeight - 50)
        
        UIApplication.shared.keyWindow?.addSubview(bgView)

        filterView.frame = CGRect(x: 0, y: 130, width: UISizeConstants.screenWidth, height: 0)
        filterView.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(filterView)
               
               
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        filterView.resize()
        filterView.alpha = 1
        bgView.alpha = 1
        UIView.commitAnimations()
    }
    
    func dismiss() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        filterView.setHeight(with: 0)
        UIView.commitAnimations()
        filterView.removeFromSuperview()
        bgView.removeFromSuperview()
    }
}

class KeywordFilterView: UIView, JFBuddleViewDelegate {
    var selectedAction: SelectedKeyword?
    var cancelAction: Cancel?
    var keyword: String?
    var keywords: [String] = []
    
    var contentHeight: CGFloat = 0
    
    @IBOutlet weak var buttonsView: UIView!
    
    var bubbleView: JFSelectBubbleView = JFSelectBubbleView()
    
    class func loadXib() -> KeywordFilterView {
        return Bundle.main.loadNibNamed("KeywordFilterView", owner: self, options: nil)!.first as! KeywordFilterView
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.keywords = KeywordsRepo.queryKeywords()
        bubbleView = JFSelectBubbleView.init(frame: CGRect(x: 0, y: 0, width: self.width, height: 120))
        bubbleView.dataArray = NSMutableArray.init(array: self.keywords)
        bubbleView.bubbleDelegate = self
        bubbleView.allowsMultipleSelection = false
        self.addSubview(bubbleView)
        self.contentHeight = bubbleView.contentSize.height + 50
        
    }
    
    func resize() {
        self.setHeight(with: contentHeight)
        bubbleView.setHeight(with: contentHeight - 50)
        self.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    @IBAction func cancel() {
        self.cancelAction?()
    }
    @IBAction func done() {
        self.selectedAction?(keyword)
    }
    
    func bubbleView(_ bubbleView: JFBubbleView!, didSelect item: JFBubbleItem!) {
        self.keyword = item.textLabel.text
    }

    func bubbleView(_ bubbleView: JFBubbleView!, didDeselect item: JFBubbleItem!) {
        self.keyword = nil
    }
}

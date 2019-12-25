//
//  KeywordsScrollView.swift
//  Treasures
//
//  Created by wang xiaoliang on 2019/12/24.
//  Copyright © 2019 joanfen. All rights reserved.
//

import UIKit

class KeywordsScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)        
    }

    
    func reloadWidth(keys:[String],height:CGFloat = 24) {
        var maxX:CGFloat = 0
        let offset:CGFloat = 10
        let y = (self.frame.height - height)/2
        for i in 0..<keys.count {
            let key = keys[i]
            let lbl = UILabel()
            let width = labelSize(text: key, attributes: [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont.boldSystemFont(ofSize: 12)]).width + 12
            lbl.text = key
            lbl.textAlignment = .center
            lbl.font = UIFont.systemFont(ofSize: 12)
            lbl.frame = CGRect(x: maxX, y: y, width: width, height: height)
            lbl.textColor = .white
            lbl.backgroundColor = UIColor.colorWithHexString(hex: "B1B8BD")
            lbl.layer.cornerRadius = height/2
            lbl.layer.masksToBounds = true
            self.addSubview(lbl)
            maxX += (width + offset)
        }
        self.contentSize = CGSize(width: maxX, height: self.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //动态设置文字大小
    func labelSize(text:String ,attributes : [NSAttributedString.Key : Any],maxWidth:CGFloat = 0, maxHeight:CGFloat = 0) -> CGRect{
        var size = CGRect();
        let size2 = CGSize(width: maxWidth, height: maxHeight);//设置label的最大宽度
        size = text.boundingRect(with: size2, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes , context: nil);
        return size
    }
}

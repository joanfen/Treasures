//
//  UISizeConstants.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/5.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import UIKit
struct UISizeConstants {
    static let top = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 34.0
    static let screenSize = UIScreen.main.bounds.size
    static let screenWidth = UISizeConstants.screenSize.width
    static let screenHeight = UISizeConstants.screenSize.height

}

extension UIView {
    var origin: CGPoint {
        get {
            return self.frame.origin
        }
    }

    var size: CGSize {
          get {
            return self.frame.size
          }
      }
    
    var x: CGFloat {
        get {
            return self.origin.x
        }
    }
    
    var y: CGFloat {
       get {
           return self.origin.y
       }
    }

    var width: CGFloat {
        get {
            return self.size.width
        }
    }
    var height: CGFloat {
        get {
            return self.size.height
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.height + self.y
        }
    }
    
    func setY(with y: CGFloat) {
        let rect = self.frame
        self.frame = CGRect.init(origin: CGPoint.init(x: rect.origin.x, y: y), size: rect.size)
    }
    
    func setWidth(with width: CGFloat) {
        let rect = self.frame
        self.frame = CGRect.init(origin: rect.origin, size: CGSize.init(width: width, height: rect.size.height))
    }
    
    func setHeight(with height: CGFloat) {
        let rect = self.frame
        self.frame = CGRect.init(origin: rect.origin, size: CGSize.init(width: width, height: height))
    }
}

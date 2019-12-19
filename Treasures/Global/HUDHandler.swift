//
//  HUDHandler.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/19.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import UIKit

class HUDHandler {
        
    class func successHUD(with text: String?) -> JGProgressHUD {
        let hud = JGProgressHUD.init(style: .extraLight)
        hud.textLabel.text = text
        hud.indicatorView = JGProgressHUDSuccessIndicatorView.init()
        hud.dismiss(afterDelay: 1)
        return hud
    }
    
    class func errorHUD(with text: String?) -> JGProgressHUD {
        let hud = JGProgressHUD.init(style: .extraLight)
        hud.textLabel.text = text
        hud.indicatorView = JGProgressHUDErrorIndicatorView.init()
        hud.dismiss(afterDelay: 1)
        return hud
    }
    
    class func showSuccess(with text: String?, in view: UIView) {
        successHUD(with: text).show(in: view)
    }
    
    class func showError(with text: String?, in view: UIView) {
        errorHUD(with: text).show(in: view)
    }
    
    
}

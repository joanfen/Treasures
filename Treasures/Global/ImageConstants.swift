//
//  ImageConstrants.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import UIKit
struct ImageConstants {
    static let upNormal = UIImage.init(named: "up1")
    static let upHighlight = UIImage.init(named: "up2")
    static let downNormal = UIImage.init(named: "down1")
    static let downHiglight = UIImage.init(named: "down2")
    
    static func up(with selected: Bool) -> UIImage {
        return (selected ? ImageConstants.upNormal : ImageConstants.upHighlight)!
    }
}

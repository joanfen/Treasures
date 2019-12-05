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

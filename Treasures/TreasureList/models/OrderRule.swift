//
//  OrderRule.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation

enum OrderRule {
    case none
    case asc
    case desc
    
    func next() -> OrderRule {
        switch self {
        case .asc: // 从升序到降序
            return OrderRule.desc
        case .desc: // 从降序到取消排序
            return OrderRule.none
        case .none: // 从取消排序到升序
            return OrderRule.asc
        }
    }
}

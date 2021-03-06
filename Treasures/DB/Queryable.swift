//
//  Queryable.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import WCDBSwift

protocol Queryable {
    func page() -> Int
    func size() -> Int
    func toQueryConditions() -> Condition
    func toOrderBy() -> [OrderBy]
    func toProperties() -> [PropertyConvertible]
}

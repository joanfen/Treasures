//
//  CountVO.swift
//  Treasures
//
//  Created by joanfen on 2019/12/25.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation

class CountVO {
    //< 藏品总数
    var treasureCount: Int = 0
    //< 总进价
    var purchasedTotalFee: Float = 0
    //< 总售价，状态为已售的藏品的售出价格的总和
    var soldTotalFee: Float = 0
}

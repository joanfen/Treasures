//
//  Size.swift
//  Treasures
//
//  Created by joanfen on 2019/12/13.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation

struct Size {
    static let unit: String = "cm"
    static let joinChar: String = " X "
    
    var length: Int64
    var width: Int64
    var height: Int64
    
    func getSizeString() -> String {
        let join = Size.unit + Size.joinChar
        return String(length) + join  + String(width) + join + String(height) + Size.unit
    }
    
    func getVolume() -> CLong {
        return CLong(length * width * height)
    }
    
}

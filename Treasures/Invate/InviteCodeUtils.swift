//
//  InviteCodeUtils.swift
//  Treasures
//
//  Created by joanfen on 2019/12/27.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation

class InviteCodeUtils {
    
    private static let BASE: [String] = ["H", "V", "E", "8", "S", "2", "D", "Z", "X", "9", "C", "7", "P",
    "5", "I", "K", "3", "M", "J", "U", "F", "R", "4", "W", "Y", "L", "T", "N", "6", "B", "G", "Q"]
    private static let SUFFIX_CHAR: String = "A"
    private static let CODE_LEN = 6
    
    class func encode(by number: CLong) -> String  {
        var id = number
        let BIN_LEN = BASE.count
        var charPos = BIN_LEN
        var buf : [String] = [String].init(repeating: "", count: BIN_LEN)
        
        while ( id / BIN_LEN > 0) {
            let index: Int = (id % BIN_LEN);
            charPos -= 1
            buf[charPos] = BASE[index];
            id /= BIN_LEN;
            
        }
        charPos -= 1
        buf[charPos] = BASE[ id  % BIN_LEN ]
        var result = buf.joined(separator: "")
        
        let len = result.count
        if (len < CODE_LEN) {
            var sb: String = SUFFIX_CHAR
            
            let random = arc4random_uniform(UInt32(BIN_LEN))
            
            // 去除SUFFIX_CHAR本身占位之后需要补齐的位数
            for _ in 0...CODE_LEN - len - 1 {
                sb = sb + BASE[Int(random)]
            }
            result += sb
        }
        return result
    }
    
    class func decode(by code: String) -> CLong {
        let BIN_LEN = BASE.count
        let charArray = code.map { String($0) }
        
        var result: CLong = 0;
        for i in 0..<charArray.count {
            var index = 0
            for j in 0..<BIN_LEN {
                if charArray[i] == BASE[j] {
                    index = j
                    break
                }
            }
            if charArray[i] == SUFFIX_CHAR {
                break;
            }
            if i > 0 {
                result = result * BIN_LEN + index
            } else {
                result = index;
            }
        }
        return result;
    }
}

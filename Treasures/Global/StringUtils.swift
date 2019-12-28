//
//  StringUtils.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/28.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation

extension String {
    func componentsExcludeWhiteSpace(by spliter: String) -> [String] {
        return self.components(separatedBy: spliter).filter({ (str) -> Bool in
            str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count > 0
        })
    }
}

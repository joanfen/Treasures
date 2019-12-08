//
//  PathHandler.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import UIKit
class PathHandler {
    static func documentPath() -> String {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        return documentPaths.first ?? ""
    }
    static func imageDirectory() -> String {
        return PathHandler.documentPath() + "/images"
    }
    
    static func saveImage(of treasureId: Int, img: UIImage, name: String){
        let imagePath = getFilePath(of: treasureId, name: name)
        do {
        try FileManager.default.createDirectory(atPath: treasurePath(with: treasureId), withIntermediateDirectories: true, attributes: nil)
        } catch {
            
        }
        let result = FileManager.default.createFile(atPath: imagePath, contents:img.pngData(), attributes: nil)
        print(result)
    }
    
    static func treasurePath(with treasureId: Int) -> String {
        return imageDirectory() + "/" + String.init(treasureId)
    }
    
    static func deleteFiles(of treasureId: Int) {
        
    }
    
    static func getFilePath(of treasureId: Int, name: String) -> String {
        treasurePath(with: treasureId) + "/" + name
    }
    
    static func getImage(of treasureId: Int, imgName: String) -> UIImage? {
        let path = getFilePath(of: treasureId, name: imgName)
        return UIImage.init(contentsOfFile: path)
    }
}

//
//  PathHandler.swift
//  Treasures
//
//  Created by 张琼芳 on 2019/12/8.
//  Copyright © 2019 joanfen. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON



class PathHandler {
    static let firstCategoryName = "firstCategory";
    static let secondCategoryName = "secondCategory";
    
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
        
    static func treasurePath(with treasureId: Int?) -> String {
        let path = imageDirectory() + "/"
        if let id = treasureId {
            return path +  String.init(id)
        }
        return path
    }
    
    static func deleteFiles(of treasureId: Int) {
        
    }
    
    static func getFilePath(of treasureId: Int?, name: String) -> String {
        treasurePath(with: treasureId) + "/" + name
    }
    
    static func getImage(of treasureId: Int?, imgName: String) -> UIImage? {
        let path = getFilePath(of: treasureId, name: imgName)
        return UIImage.init(contentsOfFile: path)
    }
    
    static func getFirstCategory() -> [[String: Any]] {
        getCategoryJson(with: firstCategoryName)
    }
    
    static func getSecondCategory() -> [[String: Any]] {
        getCategoryJson(with: secondCategoryName)
    }
 
    static private func getCategoryJson(with name: String) -> [[String: Any]] {
        let jsonFilePath: String = Bundle.main.path(forResource: name, ofType: "json")!
        do {
            let jsonData:Data = try Data.init(contentsOf: NSURL(fileURLWithPath: jsonFilePath) as URL)
            let json = try JSON(data: jsonData)
            let array: [[String: Any]] = json.rawValue as! [[String : Any]]
            print(array)
            return array
        } catch let exception {
            print("获取 Json 异常: ")
            print(exception)
        }
        return []
    }
}

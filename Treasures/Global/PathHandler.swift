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
    
    static func documentPath() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    static func imageDirectory() -> URL {
        let dir = PathHandler.documentPath().appendingPathComponent("images")
        do {
            try FileManager.default.createDirectory(atPath: dir.path,
            withIntermediateDirectories: true,
            attributes: nil)
        } catch {
            
        }
        return dir
    }
    
    static func saveImage(of treasureId: Int, imgs: [UIImage]) {
        let imagePath = treasurePath(with: treasureId)
        do {
            if(!FileManager.default.fileExists(atPath: imagePath.path)) {
                try FileManager.default.createDirectory(atPath: imagePath.path,
                withIntermediateDirectories: true,
                attributes: nil)
            }
            var index = 0
            for image in imgs {
                index += 1
                let imageName = String(index) + ".jpg"
                let url = imagePath.appendingPathComponent(imageName)
                
                try? image.jpegData(compressionQuality: 1.0)?.write(to: url)
            }
        } catch {
            
        }
    }
        
    static func treasurePath(with treasureId: Int?) -> URL {
        let path = imageDirectory()
        if let id = treasureId {
            return path.appendingPathComponent(String.init(id))
        }
        return path
    }
    
    static func deleteFiles(of treasureId: Int) {
        let path = treasurePath(with: treasureId)
        do {
            try FileManager.default.removeItem(at: path)
//            let names = ["1.jpg", "2.jpg", "3.jpg"]
//            for name in names {
//                let filePath = path.appendingPathComponent(name)
//                if FileManager.default.fileExists(atPath: filePath.absoluteString) {
//                    
//                }
//            }
            
            
            
        } catch _ {
            
        }
    }
    
    
    static func getImages(of treasureId: Int?) -> [UIImage] {
        if treasureId == nil {
            return []
        }
        let path = treasurePath(with: treasureId)
            
        let names = ["1.jpg", "2.jpg", "3.jpg"]
        var images = [UIImage]()
        for name in names {
            let imageOpt = UIImage(contentsOfFile: path.appendingPathComponent(name).path)
            if let image = imageOpt {
                images.append(image)
            }
        }
        return images
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

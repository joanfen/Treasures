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
    
    static func saveImage(of treasureId: Int, imgs: [UIImage]) -> Bool {
        let path = treasurePath(with: treasureId)
        let imagePath = path.appendingPathComponent("images")
        let temp = path.appendingPathComponent("temp")
        
        do {
            try FileManager.default.createDirectory(atPath: imagePath.path,
            withIntermediateDirectories: true,
            attributes: nil)
            try FileManager.default.createDirectory(atPath: temp.path,
            withIntermediateDirectories: true,
            attributes: nil)
            var index = 0
            for image in imgs {
                index += 1
                let imageName = String(index) + ".jpg"
                let url = temp.appendingPathComponent(imageName)
                
                try? image.jpegData(compressionQuality: 1.0)?.write(to: url)
            }
        } catch {
            return false
        }
        
        return deleteFiles(of: treasureId)
        
    }
    
    static func saveThumbnail(image: UIImage)  {
        let path = documentPath()
        do {
            try FileManager.default.createDirectory(atPath: path.path,
                       withIntermediateDirectories: true,
                       attributes: nil)
            let imageName = "thumbnail.jpg"
            let url = path.appendingPathComponent(imageName)
            try? image.jpegData(compressionQuality: 1.0)?.write(to: url)
                
        } catch {
            
        }
    }

    
    static func getThumbnail() -> UIImage? {
        let path = documentPath().appendingPathComponent("thumbnail.jpg")
        let imageOpt = UIImage(contentsOfFile: path.path)
        return imageOpt
    }
    
        
    static func treasurePath(with treasureId: Int?) -> URL {
        let path = imageDirectory()
        if let id = treasureId {
            return path.appendingPathComponent(String.init(id))
        }
        return path
    }
    
    static func treasureImagesPath(of treasureId: Int) -> URL {
        let path = treasurePath(with: treasureId)
        return path.appendingPathComponent("images")
    }
    static func treasureTempPath(of treasureId: Int) -> URL {
        let path = treasurePath(with: treasureId)
        return path.appendingPathComponent("temp")
    }
    
    static func deleteFiles(of treasureId: Int) -> Bool {
        let path = treasureImagesPath(of: treasureId)
        let temp = treasureTempPath(of: treasureId)
        do {
            try FileManager.default.removeItem(at: path) // 删除 images 文件夹中的图片
            try FileManager.default.copyItem(at: temp, to: path) // 拷贝 temp 中的图片到 images 中
            try FileManager.default.removeItem(at: temp) // 删除 temp 文件夹中的图片
            
        } catch _ {
            return false
        }
        return true
    }
    
    static func getImagePaths(of treasureId: Int?) -> [String] {
        if treasureId == nil {
            return []
        }
        
        let path = treasureImagesPath(of: treasureId!)
            
        let names = ["1.jpg", "2.jpg", "3.jpg", "4.jpg"]
        var imagePaths = [String]()
        for name in names {
            let p = path.appendingPathComponent(name).path
            if let _ = UIImage(contentsOfFile: p) {
                imagePaths.append(p)
            }
        }
        return imagePaths
    }
    static func getImages(of treasureId: Int?) -> [UIImage] {
    
        var images = [UIImage]()
        
        for name in getImagePaths(of: treasureId) {
            if let image = UIImage(contentsOfFile: name) {
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

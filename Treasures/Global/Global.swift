//
//  Global.swift
//  MiniPOS
//
//  Created by 한동 on 16/7/28.
//  Copyright © 2016年 한동. All rights reserved.
//

import UIKit




let ScreenSize = UIScreen.main.bounds

func RectMake(_ x: Int,_ y: Int,_ width: Int,_ height: Int) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}
func RectMake(_ x: CGFloat,_ y: CGFloat,_ width: CGFloat,_ height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}
func RectMake(_ x: Double,_ y: Double,_ width: Double,_ height: Double) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

func SizeMake(_ width: Int,_ height: Int) -> CGSize {
    return CGSize(width: width, height: height)
}
func SizeMake(_ width: CGFloat,_ height: CGFloat) -> CGSize {
    return CGSize(width: width, height: height)
}
func SizeMake(_ width: Double,_ height: Double) -> CGSize {
    return CGSize(width: width, height: height)
}

func PointMake(_ x: Int,_ y: Int) -> CGPoint {
    return CGPoint(x: x, y: y)
}
func PointMake(_ x: CGFloat,_ y: CGFloat) -> CGPoint {
    return CGPoint(x: x, y: y)
}
func PointMake(_ x: Double,_ y: Double) -> CGPoint {
    return CGPoint(x: x, y: y)
}


//** 延时函数 **/
func delay(delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
//** 运行平台 **/
struct RunningPlatform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}
//** 打印输出 **/
func printLog<T>(_ message: T,
              logError: Bool = false,
              file: String = #file,
              method: String = #function,
              line: Int = #line)
{
    if logError {
        print("\(judgeMainThread()), \((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    } else {
        #if DEBUG
        print("\(judgeMainThread()), \((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
        #endif
    }
}



func judgeMainThread() -> String {
    if Thread.current.isMainThread {
        return "Main"
    }
    if Thread.current.name != "" {
        return Thread.current.name!
    } else {
        let machTID = pthread_mach_thread_np(pthread_self())
        return "thread-" + "\(machTID)"
    }
}

//** 获取当前view所在控制器 **/
func parentViewController(currentView: UIView)-> UIViewController? {
    var parentResponder: UIResponder? = currentView
    while parentResponder != nil {
        parentResponder = parentResponder!.next
        if let viewController = parentResponder as? UIViewController {
            return viewController
        }
    }
    return nil
}

func isFullScreen() -> Bool {
    if #available(iOS 11.0, *) {
        guard let del = UIApplication.shared.delegate else {return false}
        guard let win = del.window else {return false}
        guard let window = win else {return false}
        let safeAreaBottom = window.safeAreaInsets.bottom
        if (safeAreaBottom > 0) {
           return true
        }
    }
    return false
}


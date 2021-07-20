//
//  UIFontExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/5/31.
//

import Foundation
import UIKit

extension UIFont {
    /// 首页左上角的字体
    /// - Returns: 字体
    static func upcornerFont() -> UIFont {
        return UIFont.init(name: "PingFangSC-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14)
    }
    
    /// 获取指定大小的苹果平方中黑体字体
    /// - Parameter size: 字号
    /// - Returns: 字体
    static func PingFangSC_Medium(_ size:CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    /// 获取指定大小的苹果平方常规体字体
    /// - Parameter size: 字号
    /// - Returns: 字体
    static func PingFangSC_Regular(_ size:CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func PingFangSC_Semibold(_ size:CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func Arial_BoldMT(_ size:CGFloat) -> UIFont {
        return UIFont.init(name: "Arial-BoldMT", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

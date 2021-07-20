//
//  UIColorExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/5/31.
//

import Foundation
import UIKit

extension UIColor {
    /// 根据输入的16进制获取颜色值
    /// - Parameter hex: 就是16进制表示的整数，形式为0xffffff，只限于此，顺序为rgb.
    /// - Returns: 获得的颜色
    static func colorFromHex(_ hex:Int) -> UIColor {
        let redInt:Int = (hex & 0xff0000) >> 16
        let greenInt:Int = (hex & 0xff00) >> 8
        let blueInt:Int = hex & 0xff
        let redFloat:CGFloat = CGFloat.init(redInt) / 255
        let greenFloat:CGFloat = CGFloat.init(greenInt) / 255
        let blueFloat:CGFloat = CGFloat.init(blueInt) / 255
        return UIColor.init(red: redFloat, green: greenFloat, blue: blueFloat, alpha: 1)
    }
    
    /// 根据输入的16进制整数获取颜色
    /// - Parameter hex: 16进制整数，代表rgba，形式为0xffffffff
    /// - Returns: 获得的颜色
    static func colorWithAlphaFromHex(_ hex:Int) -> UIColor {
        let redInt:Int = (hex & 0xff000000) >> 24
        let greenInt:Int = (hex & 0xff0000) >> 16
        let blueInt:Int = (hex & 0xff00) >> 8
        let alphaInt:Int = hex & 0xff
        let redFloat:CGFloat = CGFloat.init(redInt) / 255
        let greenFloat:CGFloat = CGFloat.init(greenInt) / 255
        let blueFloat:CGFloat = CGFloat.init(blueInt) / 255
        let alphaFloat:CGFloat = CGFloat.init(alphaInt) / 255
        return UIColor.init(red: redFloat, green: greenFloat, blue: blueFloat, alpha: alphaFloat)
    }
    
    /// 站位用的颜色，表明待填充
    /// - Returns: 站位颜色
    static func placeholderColor0() -> UIColor {
        return .green
    }
    
    /// 站位用的颜色，表明待填充
    /// - Returns: 站位颜色
    static func placeholderColor1() -> UIColor {
        return .red
    }
    
    /// 站位用的颜色，表明待填充
    /// - Returns: 站位颜色
    static func placeholderColor2() -> UIColor {
        return .blue
    }
    
    /// 这指的是与首页位于导航栏上面的颜色
    /// 相同的颜色
    /// - Returns: 导航栏按钮颜色
    static func upcornerColor() -> UIColor {
        return UIColor.colorFromHex(0x43D3ED)
    }
}

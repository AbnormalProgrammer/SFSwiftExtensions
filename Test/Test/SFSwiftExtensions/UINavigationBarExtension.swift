//
//  UINavigationBarExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/11.
//

import Foundation
import UIKit

public extension UINavigationBar {
    /// 设置导航栏的背景色
    /// - Parameter color: 输入的颜色
    /// - Returns: 空
    func setBackgroundColor(_ color:UIColor) -> Void {
        self.setBackgroundImage(UIImage.pureColorImage(color), for: .default)
        self.shadowImage = UIImage.init()
    }
    
    /// 设置navigationbar的字体和颜色
    /// - Parameters:
    ///   - color: 字体颜色
    ///   - font: 字体
    /// - Returns: 空
    func setTitleColorFont(_ color:UIColor,_ font:UIFont) -> Void {
        self.titleTextAttributes = [.foregroundColor:color,.font:font]
    }
    
    /// 设置navigationbar标题的颜色
    /// - Parameter color: 输入的颜色
    /// - Returns: 空
    func setTitleColor(_ color:UIColor) -> Void {
        self.titleTextAttributes = [.foregroundColor:color]
    }
}

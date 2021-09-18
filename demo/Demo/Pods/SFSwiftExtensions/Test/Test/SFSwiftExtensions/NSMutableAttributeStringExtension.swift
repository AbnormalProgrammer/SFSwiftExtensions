//
//  NSMutableAttributeStringExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/11.
//

import Foundation
import UIKit

public extension NSMutableAttributedString {
    /// 就是一般性的属性文字
    /// 可以用于一般的页面
    /// - Parameters:
    ///   - text: 文字内容
    ///   - font: 文字字体
    ///   - textColor: 文字颜色
    /// - Returns: 属性文字
    static func normalText(_ text:String?,_ font:UIFont,_ textColor:UIColor) -> NSAttributedString {
        let attributeTitle:NSMutableAttributedString = NSMutableAttributedString.init(string: text ?? "")
        attributeTitle.addAttributes([.foregroundColor:textColor,.font:font], range: NSRange.init(location: 0, length: attributeTitle.length))
        return attributeTitle
    }
}

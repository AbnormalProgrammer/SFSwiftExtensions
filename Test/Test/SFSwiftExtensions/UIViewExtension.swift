//
//  UIViewExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/7.
//

import Foundation
import UIKit

public extension UIView {
    /// 判断子视图中是否存在指定类型的视图
    /// - Parameter inputType: 输入的类型
    /// - Returns: 是否存在
    func isSomeTypeInSubviews(_ inputType:AnyClass) -> Bool {
        if self.subviews.count == 0 {
            return false
        }
        for iterator in self.subviews {
            if iterator.isKind(of: inputType) {
                return true
            }
        }
        return false
    }
    
    /// 在子视图层次中找到指定类型的
    /// 视图实例
    /// - Parameter inputType: 输入的类型
    /// - Returns: 结果
    func findViewInSubviews(_ inputType:AnyClass) -> UIView? {
        var result:UIView?
        for iterator in self.subviews {
            if iterator.isKind(of: inputType.self) {
                result = iterator
            }
        }
        return result
    }
}

//
//  UITabBarControllerExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/2.
//

import Foundation
import UIKit

extension UITabBarController {
    /// 因为UITabBarController的tabBar是只读的属性
    /// 所以直接赋值是做不到的，因此这里通过KVC来重置
    /// UITabBarController的tabBar
    /// - Parameter tabbar: 新的自定义的tabBar
    /// - Returns: 空
    func setNewTabBar(_ tabbar:UITabBar) -> Void {
        self.setValue(tabbar, forKey: "tabBar")
    }
}

//
//  UIImageExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/5/31.
//

import Foundation
import UIKit

extension UIImage {
    /// 用来占位的图片
    /// - Returns: 展位图片
    static func placeholderImage0() -> UIImage {
        return .remove
    }
    
    /// 生成TabBar的背景图
    /// - Returns: 图像
    static func tabBarBackgroundImage(_ width:CGFloat) -> UIImage {
        let targetSize:CGSize = CGSize.init(width: width, height: 64)
        UIGraphicsBeginImageContext(targetSize)
        let middleWidth:CGFloat = 85
        let peak:CGFloat = 15
        let path:UIBezierPath = UIBezierPath.init()
        let offset:CGFloat = 22
        let bottom = peak + 3
        path.move(to: CGPoint.init(x: 0, y: peak))
        path.addLine(to: CGPoint.init(x: (width - middleWidth) / 2, y: peak))
        path.addCurve(to: CGPoint.init(x: width / 2, y: 0), controlPoint1: CGPoint.init(x: (width - middleWidth) / 2 + offset, y: peak), controlPoint2: CGPoint.init(x: width / 2 - offset, y: 0))
        path.addCurve(to: CGPoint.init(x: width / 2 + middleWidth / 2, y: peak), controlPoint1: CGPoint.init(x: width / 2 + offset, y: 0), controlPoint2: CGPoint.init(x: width / 2 + middleWidth / 2 - offset, y: peak))
        path.addLine(to: CGPoint.init(x: width, y: peak))
        path.addLine(to: CGPoint.init(x: width, y: bottom))
        path.addLine(to: CGPoint.init(x: 0, y: bottom))
        path.close()
        UIColor.white.setFill()
        path.fill()
        let result:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard result != nil else {
            return UIImage.init()
        }
        return result!
    }
    
    /// 生成一张纯色的图片
    /// 尺寸为100x100
    /// - Parameter color: 输入的颜色
    /// - Returns: 生成的图片
    static func pureColorImage(_ color:UIColor) -> UIImage {
        let imageSize:CGSize = CGSize.init(width: 100, height: 100)
        let imageFrame:CGRect = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: imageSize.width, height: imageSize.height))
        UIGraphicsBeginImageContext(imageSize)
        let context:CGContext? = UIGraphicsGetCurrentContext()
        guard context != nil else {
            return UIImage.init()
        }
        context!.setFillColor(color.cgColor)
        context!.fill(imageFrame)
        let result:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard result != nil else {
            return UIImage.init()
        }
        return result!
    }
    
    /// 获取没有被渲染的原版的图像
    /// - Returns: 原版图像
    func origin() -> UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
    
    /// 获取一个纯色的指定直径的圆形图片
    /// - Parameters:
    ///   - inputColor: 输入的颜色
    ///   - diameter: 图片的直径
    /// - Returns: 图像
    static func pureColorCircle(_ inputColor:UIColor,_ diameter:CGFloat) -> UIImage {
        let targetSize:CGSize = CGSize.init(width: diameter, height: diameter)
        UIGraphicsBeginImageContext(targetSize)
        let path:UIBezierPath = UIBezierPath.init(ovalIn: CGRect.init(origin: CGPoint.zero, size: targetSize))
        path.close()
        inputColor.setFill()
        path.fill()
        let result:UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard result != nil else {
            return UIImage.init()
        }
        return result!
    }
}

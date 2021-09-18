//
//  CGRectExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/1.
//

import Foundation
import UIKit
import GLKit

public extension CGRect {
    /// 获取以本视图的bounds为父框架
    /// 输入指定尺寸的子视图的bounds
    /// 并让子视图自动与父视图的中心对齐
    /// - Returns: 中心对齐的子视图的frame
    func centralFrameOfSubview(_ inputSize:CGSize) -> CGRect {
        let center:CGPoint = CGPoint.init(x: self.midX, y: self.midY)
        let result:CGRect = CGRect.frameBy(center: center, size: inputSize)
        return result
    }
    
    /// 通过中心点坐标和尺寸大小
    /// 计算生成CGRect
    /// - Parameters:
    ///   - inputCenter: 输入的中心点坐标
    ///   - inputSize: 输入的尺寸
    /// - Returns: 生成的Rect
    static func frameBy(center inputCenter:CGPoint,size inputSize:CGSize) -> CGRect {
        let tempOrigin:CGPoint = CGPoint.init(x: inputCenter.x - inputSize.width / 2, y: inputCenter.y - inputSize.height / 2)
        return CGRect.init(origin: tempOrigin, size: inputSize)
    }
}

public extension CGSize {
    /// 把原来尺寸以中心对齐的方式缩放到指定尺寸
    /// 所需要的边距
    /// - Parameter targetSize: 目标尺寸
    /// - Returns: 所需要的边距
    func insetToCentralTarget(_ targetSize:CGSize) -> UIEdgeInsets {
        var widthOffset:CGFloat = self.width - targetSize.width
        widthOffset /= 2
        var heightOffset:CGFloat = self.height - targetSize.height
        heightOffset /= 2
        return UIEdgeInsets.init(top: heightOffset, left: widthOffset, bottom: heightOffset, right: widthOffset)
    }
    
    /// 让目标尺寸与原来的尺寸在底部对齐
    /// - Parameter targetSize: 目标尺寸
    /// - Returns: 结果边距
    func insetsBottomAlign(_ targetSize:CGSize) -> UIEdgeInsets {
        var widthOffset:CGFloat = self.width - targetSize.width
        widthOffset /= 2
        let heightOffset:CGFloat = self.height - targetSize.height
        return UIEdgeInsets.init(top: heightOffset, left: widthOffset, bottom: 0, right: widthOffset)
    }
    
    /// 返回宽高相等的尺寸
    /// - Parameter edgeLength: 宽或者高
    /// - Returns: 尺寸
    static func equalSize(_ edgeLength:CGFloat) -> CGSize {
        return CGSize.init(width: edgeLength, height: edgeLength)
    }
}

public extension CGVector {
    func toGLKVector2() -> GLKVector2 {
        return GLKVector2Make(Float.init(self.dx), Float.init(self.dy))
    }
}

public extension CGFloat {
    static var pi:CGFloat {
        get {
            return CGFloat.init(Double.pi)
        }
    }
    
    static var pi_2:CGFloat {
        get {
            return CGFloat.init(Double.pi / 2)
        }
    }
    
    func toFloat() -> Float {
        return Float.init(self)
    }
    
    /// 生成随机百分比
    /// - Returns: 百分比
    static func randomPercentage() -> CGFloat {
        let molecular:CGFloat = CGFloat.init(arc4random() % 101)
        return molecular / 100
    }
    
    /// 弧度转角度
    /// - Returns: 生成的角度
    func radiansToDegree() -> CGFloat {
        return GLKMathRadiansToDegrees(self.toFloat()).toCGFloat()
    }
    
    /// 角度转弧度
    /// - Returns: 生成的弧度
    func degreesToRadian() -> CGFloat {
        return GLKMathDegreesToRadians(self.toFloat()).toCGFloat()
    }
}

public extension CGPoint {
    func addVector(_ vector:CGVector) -> CGPoint {
        return CGPoint.init(x: self.x + vector.dx, y: self.y + vector.dy)
    }
    
    func multiply(_ scale:CGFloat) -> CGPoint {
        return CGPoint.init(x: self.x * scale, y: self.y * scale)
    }
    
    func vectorFrom(_ endPoint:CGPoint) -> CGVector {
        return CGVector.init(dx: endPoint.x - self.x, dy: endPoint.y - self.y)
    }
    
    func distanceTo(_ another:CGPoint) -> CGFloat {
        return sqrt(pow(self.x - another.x, 2) + pow(self.y - another.y, 2))
    }
}

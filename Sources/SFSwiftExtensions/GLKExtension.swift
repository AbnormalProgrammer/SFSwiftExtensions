//
//  HomogeneousMatrix.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/3.
//

import Foundation
import GLKit
/*
 用来计算其次矩阵相关
 */
extension GLKMatrix4 {
    /// 打印其次矩阵的各个分量，以便调试
    /// - Returns: 空
    func printMatrix() -> Void {
        print(self.m00,self.m01,self.m02,self.m03)
        print(self.m10,self.m11,self.m12,self.m13)
        print(self.m20,self.m21,self.m22,self.m23)
        print(self.m30,self.m31,self.m32,self.m33)
    }
    
    /// 生成一个全0矩阵
    /// - Returns: 结果矩阵
    static func gainZeroMatrix() -> GLKMatrix4 {
        return GLKMatrix4.init(m: (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0))
    }
    
    /// 矩阵乘法，使用点语法更加方便
    /// - Parameter matrix: 输入的矩阵
    /// - Returns: 结果矩阵
    func multiplyMatrix(_ matrix:GLKMatrix4) -> GLKMatrix4 {
        return GLKMatrix4Multiply(self, matrix)
    }
    
    /// 右乘4维向量
    /// - Parameter vector: 待乘的向量
    /// - Returns: 结果
    func multiplyVector(_ vector:GLKVector4) -> GLKVector4 {
        return GLKMatrix4MultiplyVector4(self, vector)
    }
    
    /// 输入正余弦的值得到绕X轴旋转的矩阵
    /// - Parameters:
    ///   - sinValue: 正弦值
    ///   - cosValue: 余弦值
    /// - Returns: 旋转矩阵
    static func xRotationMatrix(_ sinValue:Float,_ cosValue:Float) -> GLKMatrix4 {
        return GLKMatrix4MakeWithColumns(GLKVector4Make(1, 0, 0, 0),
                                         GLKVector4Make(0, cosValue, sinValue, 0),
                                         GLKVector4Make(0, -sinValue, cosValue, 0),
                                         GLKVector4Make(0, 0, 0, 1))
    }
    
    /// 输入正余弦的值得到绕Y轴旋转的矩阵
    /// - Parameters:
    ///   - sinValue: 正弦值
    ///   - cosValue: 余弦值
    /// - Returns: 旋转矩阵
    static func yRotationMatrix(_ sinValue:Float,_ cosValue:Float) -> GLKMatrix4 {
        return GLKMatrix4MakeWithColumns(GLKVector4Make(cosValue, 0, -sinValue, 0),
                                         GLKVector4Make(0, 1, 0, 0),
                                         GLKVector4Make(sinValue, 0, cosValue, 0),
                                         GLKVector4Make(0, 0, 0, 1))
    }
    
    /// 输入正余弦的值得到绕Z轴旋转的矩阵
    /// - Parameters:
    ///   - sinValue: 正弦值
    ///   - cosValue: 余弦值
    /// - Returns: 旋转矩阵
    static func zRotationMatrix(_ sinValue:Float,_ cosValue:Float) -> GLKMatrix4 {
        return GLKMatrix4MakeWithColumns(GLKVector4Make(cosValue, sinValue, 0, 0),
                                         GLKVector4Make(-sinValue, cosValue, 0, 0),
                                         GLKVector4Make(0, 0, 1, 0),
                                         GLKVector4Make(0, 0, 0, 1))
    }
}

extension GLKVector2 {
    func model() -> Float {
        return GLKVector2Length(self)
    }
}

extension GLKVector3 {
    func fork(_ another:GLKVector3) -> GLKVector3 {
        return GLKVector3CrossProduct(self, another)
    }
    
    /// 获取单位向量
    /// - Returns: 单位向量
    func toUnit() -> GLKVector3 {
        let model:Float = GLKVector3Length(self)
        return GLKVector3Make(self.x / model, self.y / model, self.z / model)
    }
    
    func multipy(_ scale:Float) -> GLKVector3 {
        return GLKVector3MultiplyScalar(self, scale)
    }
    
    func add(_ another:GLKVector3) -> GLKVector3 {
        return GLKVector3Add(self, another)
    }
}

extension GLKVector4 {
    static func zero4() -> GLKVector4 {
        return GLKVector4Make(0, 0, 0, 0)
    }
    
    func model() -> Float {
        return GLKVector4Length(self)
    }
}



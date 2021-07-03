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
    
    /// 根据输入的3D点坐标
    /// 在标准单位空间内
    /// 按照给定的向量
    /// 对该点进行旋转
    /// 然后输出结果
    /// 这里采用的是UIKit坐标系，也就是左手坐标系
    /// - Parameters:
    ///   - originalPoint: 待旋转的点坐标
    ///   - directionVector: 给点的方向向量，这里给定的是二维向量，所以z坐标必然是0
    ///   - arc: 给定的旋转角度
    /// - Returns: 结果点坐标
    static func rotatePointByAnyAxis(_ originalPoint:LP3DPoint,_ directionVector:CGVector,_ arc:CGFloat) -> LP3DPoint {
        let glkVector2:GLKVector2 = directionVector.toGLKVector2()
        let directionVectorModel:Float = GLKVector2Length(glkVector2)
        guard directionVectorModel > 0 && arc != 0 else {
            return originalPoint
        }
        let originalVector:GLKVector4 = originalPoint.toGLKVector4()
        
        var resultMatrix:GLKMatrix4 = GLKMatrix4Identity
        
        /*1、绕X轴旋转到XOY平面*/
        var matrix0:GLKMatrix4 = GLKMatrix4Identity
        if glkVector2.y * glkVector2.y != 0 {
            let cos0:Float = glkVector2.y / directionVectorModel
            let sin0:Float = 0
            matrix0 = GLKMatrix4MakeWithRows(GLKVector4Make(1, 0, 0, 0),
                                             GLKVector4Make(0, cos0, -sin0, 0),
                                             GLKVector4Make(0, sin0, cos0, 0),
                                             GLKVector4Make(0, 0, 0, 1))
        }
        
        /*2、绕Z轴旋转到Y轴*/
        var matrix1:GLKMatrix4 = GLKMatrix4Identity
        if glkVector2.y * glkVector2.y + glkVector2.x * glkVector2.x != 0 {
            let cos1:Float = glkVector2.y / directionVectorModel
            let sin1:Float = glkVector2.x / directionVectorModel
            matrix1 = GLKMatrix4MakeWithRows(GLKVector4Make(cos1, -sin1, 0, 0),
                                             GLKVector4Make(sin1, cos1, 0, 0),
                                             GLKVector4Make(0, 0, 1, 0),
                                             GLKVector4Make(0, 0, 0, 1))
        }
        
        /*3、绕Y轴旋转*/
        let cos2:Float = Float.init(cos(arc))
        let sin2:Float = Float.init(sin(arc))
        let matrix2:GLKMatrix4 = GLKMatrix4MakeWithRows(GLKVector4Make(cos2, 0, sin2, 0),
                                                        GLKVector4Make(0, 1, 0, 0),
                                                        GLKVector4Make(-sin2, 0, cos2, 0),
                                                        GLKVector4Make(0, 0, 0, 1))
        /*4、绕Z轴旋转到XOY平面*/
        var matrix3:GLKMatrix4 = GLKMatrix4Identity
        if glkVector2.y * glkVector2.y + glkVector2.x * glkVector2.x != 0 {
            let cos1:Float = glkVector2.y / directionVectorModel
            let sin1:Float = glkVector2.x / directionVectorModel
            matrix3 = GLKMatrix4MakeWithRows(GLKVector4Make(cos1, sin1, 0, 0),
                                             GLKVector4Make(-sin1, cos1, 0, 0),
                                             GLKVector4Make(0, 0, 1, 0),
                                             GLKVector4Make(0, 0, 0, 1))
        }
        /*5、最后旋转回原来的位置*/
        var matrix4:GLKMatrix4 = GLKMatrix4Identity
        if glkVector2.y * glkVector2.y != 0 {
            let cos0:Float = glkVector2.y / directionVectorModel
            let sin0:Float = 0
            matrix4 = GLKMatrix4MakeWithRows(GLKVector4Make(1, 0, 0, 0),
                                             GLKVector4Make(0, cos0, sin0, 0),
                                             GLKVector4Make(0, -sin0, cos0, 0),
                                             GLKVector4Make(0, 0, 0, 1))
        }
        
        resultMatrix = GLKMatrix4Multiply(matrix4, matrix3)
        resultMatrix = GLKMatrix4Multiply(resultMatrix, matrix2)
        resultMatrix = GLKMatrix4Multiply(resultMatrix, matrix1)
        resultMatrix = GLKMatrix4Multiply(resultMatrix, matrix0)
        let resultVector4 = GLKMatrix4MultiplyVector4(resultMatrix, originalVector)
        return LP3DPoint.init(resultVector4)
    }
    
    /// 给定点绕某一向量旋转一定角度得到结果点坐标
    /// - Parameters:
    ///   - inputPoint: 原始点坐标
    ///   - axis: 旋转轴
    ///   - radians: 旋转的弧度
    /// - Returns: 结果点坐标
    static func rotateByAnyVector(_ inputPoint:LP3DPoint,_ axis:GLKVector3,_ radians:CGFloat) -> LP3DPoint {
        let vectorModel:Float = GLKVector3Length(axis)
        let unitVector:GLKVector3 = GLKVector3Make(axis.x / vectorModel, axis.y / vectorModel, axis.z / vectorModel)
        var tempResult:GLKVector3 = inputPoint.toGLKVector3()
        tempResult = GLKVector3MultiplyScalar(tempResult, cos(Float.init(radians)))
        tempResult = GLKVector3Add(tempResult, GLKVector3MultiplyScalar(GLKVector3CrossProduct(unitVector, inputPoint.toGLKVector3()), sin(Float.init(radians))))
        tempResult = GLKVector3Add(tempResult, GLKVector3MultiplyScalar(GLKVector3MultiplyScalar(unitVector, GLKVector3DotProduct(unitVector,inputPoint.toGLKVector3())), 1 - cos(Float.init(radians))))
        return LP3DPoint.init(tempResult)
    }
    
    /// 根据输入的点坐标
    /// 旋转轴
    /// 以及旋转角度
    /// 求出旋转以后的点坐标
    /// 这里使用的是左手坐标系
    /// - Parameters:
    ///   - inputPoint: 输入的待旋转的点坐标
    ///   - axis: 旋转轴向量，这里是二维平面向量
    ///   - radians: 旋转的弧度值
    /// - Returns: 旋转以后的点坐标
    static func rotateByAxis(_ inputPoint:LP3DPoint,_ axis:GLKVector2,_ radians:CGFloat) -> LP3DPoint {
        guard axis.model() > 0 && radians != 0 else {
            return inputPoint
        }
        let zComponent:Float = 0
        let yzLength:Float = sqrtf(powf(axis.y, 2) + powf(zComponent, 2))
        let originalVector4:GLKVector4 = GLKVector4Make(inputPoint.x.toFloat(), inputPoint.y.toFloat(), inputPoint.z.toFloat(), 0)
        let vectorLength:Float = axis.model()
        /*首先绕X轴旋转到XOY平面上去*/
        var rotateXMatrix:GLKMatrix4 = GLKMatrix4Identity
        if yzLength > 0 {
            let cos0:Float = axis.y / yzLength
            let sin0:Float = -zComponent / yzLength
            rotateXMatrix = GLKMatrix4.xRotationMatrix(sin0, cos0)
        }
        /*然后绕Z轴旋转到Y轴上面去*/
        let cos1:Float = sqrtf(powf(axis.y, 2) + powf(zComponent, 2)) / vectorLength
        let sin1:Float = axis.x / vectorLength
        let rotateZMatrix:GLKMatrix4 = GLKMatrix4.zRotationMatrix(sin1, cos1)
        /*此时正式绕Y轴旋转*/
        let cos2:Float = cos(radians).toFloat()
        let sin2:Float = sin(radians).toFloat()
        let rotateYMatrix:GLKMatrix4 = GLKMatrix4.yRotationMatrix(sin2, cos2)
        /*绕着Z旋转，转到原来在XOY平面上的位置*/
        let cos3:Float = cos1
        let sin3:Float = -sin1
        let rotateReverseZMatrix:GLKMatrix4 = GLKMatrix4.zRotationMatrix(sin3, cos3)
        /*绕X轴旋转，转回原来的位置*/
        var rotateReverseXMatrix:GLKMatrix4 = GLKMatrix4Identity
        if yzLength > 0 {
            let cos4:Float = axis.y / yzLength
            let sin4:Float = zComponent / yzLength
            rotateReverseXMatrix = GLKMatrix4.xRotationMatrix(sin4, cos4)
        }
        var tempMatrix:GLKMatrix4 = GLKMatrix4Identity
        tempMatrix = tempMatrix.multiplyMatrix(rotateReverseXMatrix)
        tempMatrix = tempMatrix.multiplyMatrix(rotateReverseZMatrix)
        tempMatrix = tempMatrix.multiplyMatrix(rotateYMatrix)
        tempMatrix = tempMatrix.multiplyMatrix(rotateZMatrix)
        tempMatrix = tempMatrix.multiplyMatrix(rotateXMatrix)
        let tempVector4:GLKVector4 = tempMatrix.multiplyVector(originalVector4)
        return LP3DPoint.init(tempVector4.x.toCGFloat(), tempVector4.y.toCGFloat(), tempVector4.z.toCGFloat())
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



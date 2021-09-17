//
//  StringExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/5/31.
//

import Foundation

public extension String {
    /// 占位用的文字
    /// - Returns: 占位用的文字
    public static func placeholder0() -> String {
        return "placeholder"
    }
    
    public static func placeholder1() -> String {
        return "to return"
    }
    
    /*
     根据正则表达式判断一个字符串是不是
     手机号码
     */
    public func isPhoneNumber() -> Bool {
        let pattern:String = "^((13[0-9])|(14[0,1,4-9])|(15[0-3,5-9])|(16[2,5,6,7])|(17[0-8])|(18[0-9])|(19[0-3,5-9]))\\d{8}$"
        var regex:NSRegularExpression = NSRegularExpression.init()
        do {
            try regex = NSRegularExpression.init(pattern: pattern, options: .caseInsensitive)
        } catch {
        }
        let matchesNumber:Int = regex.numberOfMatches(in: self, options: [], range: NSRange.init(location: 0, length: self.count))
        return matchesNumber != 0
    }
    
    /// 像数组那样访问字符串中的字符
    /// - Parameter index: 下标
    /// - Returns: 索引出来的字符因为有可能越界
    func characterOf(_ index:Int) -> Character? {
        let result:Character? = self[self.index(self.startIndex, offsetBy: index)]
        return result
    }
    
    func toData() -> Data {
        return self.data(using: .utf8) ?? Data.init()
    }
    
    /// 把字符串的路径转换为URL的路径
    /// - Returns: 路径的URL
    func toPathURL() -> URL {
        return URL.init(fileURLWithPath: self)
    }
    
    /// 附加下一段路径
    /// 带有路径分隔符的那种
    /// - Parameter subpath: 下一段路径字符串
    /// - Returns: 拼接好的路径
    func appendNextPath(_ subpath:String) -> String {
        return self.appending("/").appending(subpath)
    }
    
    /// 获取类名
    /// - Parameter type: 输入的某个类
    /// - Returns: 该类的名称
    static func gainClassName(_ type:AnyClass) -> String {
        return String.init(cString: object_getClassName(type.self))
    }
    
    /// 判断一个字符串是不是数值
    /// 把字符串进行拆分
    /// 以小数点进行拆解
    /// 最多分成2部分
    /// - Returns: 是否是数值
    func isDecimal() -> Bool {
        let splitedString:[Substring] = self.split(maxSplits: 1, omittingEmptySubsequences: false, whereSeparator: {$0 == "."})
        guard splitedString.count <= 2 && splitedString.count > 0 else {
            return false
        }
        return splitedString.allSatisfy {Int.init(String.init($0)) != nil || $0.count == 0}
    }
    
    /// 获取一个浮点型字符串的
    /// 整数部分的位数
    /// 和小数部分的位数
    /// 该方法能正常运行的前提
    /// 是你必须输入一个正确的
    /// 小数
    /// - Returns: 整数部分和小数部分位数
    func gainDigitsOfFloat() -> (Int,Int) {
        let splitedString:[Substring] = self.split(maxSplits: 1, omittingEmptySubsequences: false, whereSeparator: {$0 == "."})
        var result:(Int,Int) = (0,0)
        for index in 0..<min(splitedString.count, 2) {
            switch index {
            case 0:
                result.0 = splitedString[index].count
            default:
                result.1 = splitedString[index].count
            }
        }
        return result
    }
    
    /// 匹配正则表达式
    /// - Parameter regex: 正则表达式
    /// - Returns: 是否正确
    func matchRegularExpression(_ regex:String) -> Bool {
        var result:Bool = true
        do {
            let regexExpression:NSRegularExpression = try NSRegularExpression.init(pattern: regex, options: .caseInsensitive)
            regexExpression.enumerateMatches(in: self, options: [], range: NSRange.init(location: 0, length: self.count)) { (matchResult, flag, pointer) in
                guard let _ = matchResult else {
                    result = false
                    return;
                }
            }
        } catch {
            result = false
        }
        return result
    }
    
    /// 根据给定的采样精度字符串
    /// 去限制给定的数字字符串
    /// 这里面的精度认为是小数点后
    /// - Parameter inputSample: 精度采样字符串
    /// - Returns:阶段以后的字符串
    public func convertToSamplePrecision(_ inputSample:String) -> String {
        if self.contains(".") == false {
            return self
        } else {
            let pointIndex:Index = self.firstIndex(of: ".")!
            let elementsNumber:Int = distance(from: pointIndex, to: self.endIndex) - 1
            /*最多保留小数点后n位*/
            let digitsNumber:(Int,Int) = inputSample.gainDigitsOfFloat()
            return String.init(self[...self.index(pointIndex, offsetBy: min(elementsNumber, digitsNumber.1))])
        }
    }
}

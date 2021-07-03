//
//  StringExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/5/31.
//

import Foundation

extension String {
    /// 占位用的文字
    /// - Returns: 占位用的文字
    static func placeholder0() -> String {
        return "placeholder"
    }
    
    static func placeholder1() -> String {
        return "to return"
    }
    
    /*
     根据正则表达式判断一个字符串是不是
     手机号码
     */
    func isPhoneNumber() -> Bool {
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
}

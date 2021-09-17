//
//  TimeInternvalExtension.swift
//  BitMart
//
//  Created by Stroman on 2021/8/21.
//  Copyright © 2021 BitMart. All rights reserved.
//

import Foundation

extension TimeInterval {
    /// 根据给定的格式化字符串
    /// 把时间戳格式化成为
    /// 指定格式的时间
    /// - Parameter format: 格式化字符串
    /// - Returns: 结果
    func toFormattedString(_ format:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter:DateFormatter = DateFormatter.init()
        formatter.dateFormat = format
        return formatter.string(from: Date.init(timeIntervalSince1970: self / 1000))
    }
}

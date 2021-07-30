//
//  DecimalExtension.swift
//  BitMart
//
//  Created by Stroman on 2021/7/30.
//  Copyright © 2021 BitMart. All rights reserved.
//

import Foundation

extension Decimal {
    /*
     把十进制转换成字符串
     */
    func toString() -> String {
        var tempSelf:Decimal = self
        return NSDecimalString(&tempSelf, Locale.init(identifier:"en_US"))
    }
}

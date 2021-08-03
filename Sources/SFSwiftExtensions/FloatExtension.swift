//
//  FloatExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/8.
//

import Foundation
import UIKit

extension Float {
    func toCGFloat() -> CGFloat {
        return CGFloat.init(self)
    }
    
    func toString() -> String {
        return String.init(format: "%f", self)
    }
}

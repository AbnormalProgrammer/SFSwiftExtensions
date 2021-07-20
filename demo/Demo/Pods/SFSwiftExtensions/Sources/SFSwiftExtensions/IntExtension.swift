//
//  IntExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/5.
//

import Foundation
import UIKit

extension Int {
    func toCGFloat() -> CGFloat {
        return CGFloat.init(self)
    }
    
    func toFloat() -> Float {
        return Float.init(self)
    }
    
    func toString() -> String {
        return String.init(self)
    }
}

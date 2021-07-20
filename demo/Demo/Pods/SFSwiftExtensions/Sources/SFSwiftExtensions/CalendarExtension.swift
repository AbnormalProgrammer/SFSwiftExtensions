//
//  CalendarExtension.swift
//  LovelyPet
//
//  Created by Stroman on 2021/6/25.
//

import Foundation

extension Calendar {
    func lastYear() -> Int {
        let dateComponents:DateComponents = self.dateComponents(in: TimeZone.autoupdatingCurrent, from: Date.init())
        return dateComponents.year! - 1
    }
    
    func thisYear() -> Int {
        return self.dateComponents(in: TimeZone.autoupdatingCurrent, from: Date.init()).year!
    }
}

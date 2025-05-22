//
//  Int+Extension.swift
//  SKRangeSlider
//
//  Created by Shadab khan on 22/05/25.
//

import Foundation

extension Int {
    
    func minutesTo24HourTime() -> String {
        let hours = self / 60
        let minutes = self % 60
        
        let hourString = String(format: "%02d", hours)
        let minuteString = String(format: "%02d", minutes)
        
        return "\(hourString):\(minuteString)"
    }
    
    func addOrdinalSuffix() -> String {
        switch self {
        case 1, 21, 31:
            return "\(self)st"
        case 2, 22:
            return "\(self)nd"
        case 3, 23:
            return "\(self)rd"
        default:
            return "\(self)th"
        }
    }
    
    func getOrdinalSuffix() -> String {
        switch self {
        case 1,21,31:
            return "st"
        case 2,22:
            return "nd"
        case 3,23:
            return "rd"
        default:
            return "th"
        }
    }
}

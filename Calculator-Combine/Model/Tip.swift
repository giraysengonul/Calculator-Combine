//
//  Tip.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 27.11.2024.
//

import Foundation

@frozen public enum Tip{
    
    case none
    case tenPercent
    case fifteenPercent
    case twentyPercent
    case custom(value: Int)
    
    var stringValue: String{
        switch self{
        case .none:
            return ""
        case .tenPercent:
            return "10%"
        case .fifteenPercent:
            return "15%"
        case .twentyPercent:
            return "20%"
        case .custom(value: let value):
            return String(value)
        }
    }
    
    
}

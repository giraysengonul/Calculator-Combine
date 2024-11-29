//
//  Double+Extension.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 29.11.2024.
//

import Foundation

extension Double{
    
    var currencyFormatted: String {
        
        var isWholeNumber: Bool{
            isZero ? true: !isNormal ? false : self == rounded()
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return formatter.string(for: self) ?? ""
        
    }
    
}

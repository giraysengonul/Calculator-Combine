//
//  UIView+Extension.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit

extension UIView {
    
    public func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float){
        
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
        
    }
    
    public func addCornerRadius(cornerRadius: CGFloat){
        
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
       
    }
    
    
    public func addRoundedCorner(radius: CGFloat, corners: CACornerMask){
        
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
    
    
}

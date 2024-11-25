//
//  LabelFactory.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit

public struct LabelFactory {
    
    public static func build(
        text: String?,
        font: UIFont,
        backgroundColor: UIColor = .clear,
        textColor: UIColor = ThemeColor.text,
        textAlignment: NSTextAlignment = .center) -> UILabel{
            let label: UILabel = UILabel()
            label.text = text
            label.font = font
            label.backgroundColor = backgroundColor
            label.textColor = textColor
            label.textAlignment = textAlignment
            return label
        }
    
    
}

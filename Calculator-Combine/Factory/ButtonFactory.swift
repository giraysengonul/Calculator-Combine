//
//  ButtonFactory.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 27.11.2024.
//

import Foundation
import UIKit

public struct ButtonFactory{
    
    public static func tipInputViewButton(tip: Tip) -> UIButton {
        
        let button: UIButton = .init(type: .system)
        button.tintColor = .white
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(cornerRadius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [.font: ThemeFont.bold(ofSize: 20)])
        text.addAttributes([.font: ThemeFont.demibold(ofSize: 14)],
                           range: NSMakeRange(2,1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
    
    
}

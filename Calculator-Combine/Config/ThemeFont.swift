//
//  ThemeFont.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit

public struct ThemeFont{
    
    public static func regular(ofSize size: CGFloat) -> UIFont{
        .init(name: "AvenirNext-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    public static func bold(ofSize size: CGFloat) -> UIFont{
        .init(name: "AvenirNext-Bold", size: size) ?? .boldSystemFont(ofSize: size)
    }
    
    
    public static func demibold(ofSize size: CGFloat) -> UIFont{
        .init(name: "AvenirNext-demibold", size: size) ?? .boldSystemFont(ofSize: size)
    }
    
}

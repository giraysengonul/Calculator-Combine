//
//  UIResponder+Extension.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 28.11.2024.
//

import UIKit

extension UIResponder{
    
    var parentViewController: UIViewController?{
        return next as? UIViewController ?? next?.parentViewController
    }
}

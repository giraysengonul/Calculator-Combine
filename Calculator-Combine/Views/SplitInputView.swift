//
//  SplitInputView.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit

public final class SplitInputView: UIView {
    
     // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     // MARK: - Properties
    private func setUp(){
        //self
        backgroundColor = .green
        
    }
    private func addConstraint() {
        
    }
    
}

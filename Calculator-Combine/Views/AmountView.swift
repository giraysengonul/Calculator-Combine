//
//  AmountView.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 26.11.2024.
//

import Foundation
import UIKit

public final class AmountView: UIView {
    
    // MARK: - Properties
    
    private let title: String
    private let textAlignment: NSTextAlignment
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(
            text: title,
            font: ThemeFont.regular(ofSize: 18),
            textColor: ThemeColor.text,
            textAlignment: textAlignment)
    }()
    
    private lazy var amountLabel: UILabel = {
        let label: UILabel = .init()
        label.textAlignment = textAlignment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let vStackView: UIStackView = .init(arrangedSubviews: [
            titleLabel,
            amountLabel
        ])
        vStackView.axis = .vertical
        return vStackView
    }()
    
    // MARK: - Init
    
    public init(title: String, textAlignment: NSTextAlignment) {
        self.title = title
        self.textAlignment = textAlignment
        super.init(frame: .zero)
        setUp()
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        //self
        backgroundColor = .clear
    }
    
    private func addConstraint() {
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}


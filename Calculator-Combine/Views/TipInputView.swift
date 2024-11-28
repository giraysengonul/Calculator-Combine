//
//  TipInputView.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit

public final class TipInputView: UIView {
    
    // MARK: - Properties
    
    private let headerView: HeaderView = {
        let headerView: HeaderView = .init()
        headerView.configure(topText: "Choose", bottomText: "your tip")
        return headerView
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = ButtonFactory.tipInputViewButton(tip: .tenPercent)
        return button
    }()
    
    private lazy var fiftenPercentTipButton: UIButton = {
        let button = ButtonFactory.tipInputViewButton(tip: .fifteenPercent)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = ButtonFactory.tipInputViewButton(tip: .twentyPercent)
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let stackView: UIStackView = .init(arrangedSubviews: [
            tenPercentTipButton,
            fiftenPercentTipButton,
            twentyPercentTipButton
        ])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var customButton: UIButton = {
        let button: UIButton = .init(type: .system)
        button.setTitle("Custom", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.tintColor = .white
        button.addCornerRadius(cornerRadius: 18)
        button.backgroundColor = ThemeColor.primary
        return button
    }()
    
    
    private lazy var buttonVStackView: UIStackView = {
        let stackView: UIStackView = .init(arrangedSubviews: [
            buttonHStackView,
            customButton
        ])
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
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
        backgroundColor = .clear
        
    }
    private func addConstraint() {
        
        [headerView, buttonVStackView].forEach(addSubview(_:))
        
        buttonVStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
        
    }
    
}

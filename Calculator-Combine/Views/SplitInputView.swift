//
//  SplitInputView.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit

public final class SplitInputView: UIView {
    
    // MARK: - Properties
    private let headerView: HeaderView = {
        let headerView: HeaderView = .init()
        headerView.configure(
            topText: "Split",
            bottomText: "the total")
        return headerView
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = ButtonFactory.splitInputViewButton(
            text: "-",
            corners: [.layerMinXMaxYCorner, .layerMinXMinYCorner])
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = ButtonFactory.splitInputViewButton(
            text: "+",
            corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        return button
    }()
    
    private lazy var quantityLAbel: UILabel = {
        let label = LabelFactory.build(
            text: "1",
            font: ThemeFont.bold(ofSize: 20))
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView: UIStackView = .init(arrangedSubviews: [
            decrementButton,
            quantityLAbel,
            incrementButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
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
        
        [headerView, hStackView].forEach(addSubview(_:))
        
        hStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        [incrementButton,decrementButton].forEach { button in
            button.snp.makeConstraints { make in
                make.width.equalTo(button.snp.height)
            }
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalTo(hStackView.snp.centerY)
            make.trailing.equalTo(hStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
        }
        
    }
    
}

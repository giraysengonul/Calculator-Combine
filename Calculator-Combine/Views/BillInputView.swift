//
//  BillInputView.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit

public final class BillInputView: UIView {
    
    // MARK: - Properties
    
    private let headerView: HeaderView = {
        let headerView: HeaderView = .init(frame: .zero)
        headerView.configure(topText: "Enter", bottomText: "your bill")
        return headerView
    }()
    
    private let textFieldContainerView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .white
        view.addCornerRadius(cornerRadius: 8.0)
        return view
    }()
    
    private let currentlyDominationLabel: UILabel = {
        let label = LabelFactory.build(
            text: "$",
            font: ThemeFont.bold(ofSize: 24))
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField: UITextField = .init()
        textField.borderStyle = .none
        textField.font = ThemeFont.bold(ofSize: 28)
        textField.textColor = ThemeColor.text
        textField.tintColor = ThemeColor.text
        textField.keyboardType = .decimalPad
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        let toolBar: UIToolbar = .init(frame: .init(x: 0, y: 0, width: frame.size.width, height: 36))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        toolBar.items = [
            .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            .init(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        ]
        textField.inputAccessoryView = toolBar
        textField.isUserInteractionEnabled = true
        return textField
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
        [headerView,textFieldContainerView].forEach(addSubview(_:))
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(68)
            make.leading.equalToSuperview()
            make.trailing.equalTo(textFieldContainerView.snp.leading).offset(-24)
            make.centerY.equalTo(textFieldContainerView.snp.centerY)
        }
        
        textFieldContainerView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        [currentlyDominationLabel,textField].forEach(textFieldContainerView.addSubview(_:))
        
        currentlyDominationLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textFieldContainerView.snp.leading).offset(16)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(currentlyDominationLabel.snp.trailing).offset(16)
            make.trailing.equalTo(textFieldContainerView.snp.trailing).offset(-16)
        }
    }
    
    @objc private func doneButtonTapped(){
        textField.endEditing(true)
    }
    
}


fileprivate final class HeaderView: UIView {
    
    // MARK: - Properties
    
    private let topLabel: UILabel = {
        LabelFactory.build(
            text: nil,
            font: ThemeFont.bold(ofSize: 18))
    }()
    
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(
            text: nil,
            font: ThemeFont.regular(ofSize: 16))
    }()
    
    private let topSpacerView: UIView = UIView()
    private let bottomSpacerView: UIView = UIView()
    
    
    private lazy var vStackView: UIStackView = {
        let vStackView: UIStackView = .init(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView
        ])
        vStackView.axis = .vertical
        vStackView.spacing = -4
        vStackView.alignment = .leading
        return vStackView
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
    
    // MARK: - Helpers
    
    private func setUp(){
        backgroundColor = .clear
    }
    
    private func addConstraint() {
        
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView.snp.height)
        }
        
    }
    
    public func configure(topText: String, bottomText: String){
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
    
    
}

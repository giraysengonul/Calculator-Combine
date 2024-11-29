//
//  BillInputView.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit
import Combine
import CombineCocoa

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
    
    private var cancellable: Set<AnyCancellable> = .init()
    private let billSubject: PassthroughSubject<Double,Never> = .init()
    public var valuePublisher: AnyPublisher<Double,Never>{
        return billSubject.eraseToAnyPublisher()
    }
    
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setUp()
        addConstraint()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    private func observe(){
        
        textField.textPublisher.sink {[weak self] text in
            self?.billSubject.send(text?.doubleValue ?? 0)
        }.store(in: &cancellable)
        
    }
    
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

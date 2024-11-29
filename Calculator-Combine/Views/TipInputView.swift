//
//  TipInputView.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit
import Combine
import CombineCocoa

public final class TipInputView: UIView {
    
    // MARK: - Properties
    
    private let headerView: HeaderView = {
        let headerView: HeaderView = .init()
        headerView.configure(topText: "Choose", bottomText: "your tip")
        return headerView
    }()
    
    private lazy var tenPercentTipButton: UIButton = {
        let button = ButtonFactory.tipInputViewButton(tip: .tenPercent)
        button.tapPublisher.flatMap { _ in
            Just(Tip.tenPercent).eraseToAnyPublisher()
        }.assign(to: \.value, on: tipSubject).store(in: &cancellable)
        return button
    }()
    
    private lazy var fiftenPercentTipButton: UIButton = {
        let button = ButtonFactory.tipInputViewButton(tip: .fifteenPercent)
        button.tapPublisher.flatMap { _ in
            Just(Tip.fifteenPercent).eraseToAnyPublisher()
        }.assign(to: \.value, on: tipSubject).store(in: &cancellable)
        return button
    }()
    
    private lazy var twentyPercentTipButton: UIButton = {
        let button = ButtonFactory.tipInputViewButton(tip: .twentyPercent)
        button.tapPublisher.flatMap { _ in
            Just(Tip.twentyPercent).eraseToAnyPublisher()
        }.assign(to: \.value, on: tipSubject).store(in: &cancellable)
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
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomButton()
        }.store(in: &cancellable)
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
    
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    public var valuePublisher: AnyPublisher<Tip,Never>{
        return tipSubject.eraseToAnyPublisher()
    }
    private var cancellable = Set<AnyCancellable>()
    
    
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
    
    // MARK: - Helpers
    
    private func observe(){
        tipSubject.sink {[unowned self] tip in
            resetView()
            switch tip{
                
            case .none:
                break
            case .tenPercent:
                tenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                fiftenPercentTipButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                twentyPercentTipButton.backgroundColor = ThemeColor.secondary
            case .custom(value: let value):
                customButton.backgroundColor = ThemeColor.secondary
                let text = NSMutableAttributedString(
                    string: "$\(value)",
                    attributes: [.font: ThemeFont.bold(ofSize: 20)])
                text.addAttributes(
                    [.font: ThemeFont.bold(ofSize: 14)],
                    range: NSMakeRange(0, 1))
                customButton.setAttributedTitle(text, for: .normal)
                
            }
        }.store(in: &cancellable)
        
    }
    
    private func resetView(){
        [tenPercentTipButton, fiftenPercentTipButton, twentyPercentTipButton, customButton].forEach {
            $0.backgroundColor = ThemeColor.primary
            let text = NSMutableAttributedString(
                string: "Custom tip",
                attributes: [.font: ThemeFont.bold(ofSize: 20)])
            customButton.setAttributedTitle(text, for: .normal)
        }
    }
    
    private func handleCustomButton(){
        let alertController:UIAlertController = {
            let controller = UIAlertController(
                title: "Enter Custom Tip",
                message: nil,
                preferredStyle: .alert)
            controller.addTextField{ textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .decimalPad
                textField.autocorrectionType = .no
            }
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel)
            let okAction = UIAlertAction(
                title: "Ok",
                style: .default){[weak self] _ in
                    guard let text = controller.textFields?.first?.text, let value = Int(text) else{
                        return
                    }
                    self?.tipSubject.send(.custom(value: value))
                }
            [cancelAction,okAction].forEach(controller.addAction(_:))
            
            return controller
        }()
        parentViewController?.present(alertController, animated: true)
    }
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

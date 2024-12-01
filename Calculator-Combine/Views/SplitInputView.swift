//
//  SplitInputView.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit
import Combine
import CombineCocoa

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
        button.tapPublisher.flatMap { [unowned self] _ in
            Just(splitSubject.value == 1 ? 1 : splitSubject.value - 1)
            
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellable)
        return button
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = ButtonFactory.splitInputViewButton(
            text: "+",
            corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        button.tapPublisher.flatMap {[unowned self] _ in
            Just(splitSubject.value + 1)
        }.assign(to: \.value, on: splitSubject)
            .store(in: &cancellable)
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = LabelFactory.build(
            text: "1",
            font: ThemeFont.bold(ofSize: 20))
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView: UIStackView = .init(arrangedSubviews: [
            decrementButton,
            quantityLabel,
            incrementButton
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()
    
    private var cancellable: Set<AnyCancellable> = .init()
    private let splitSubject: CurrentValueSubject<Int, Never> = .init(1)
    public var valuePublisher: AnyPublisher<Int,Never> {
        return splitSubject.removeDuplicates().eraseToAnyPublisher()
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
    
    // MARK: - Helper
    
    private func observe(){
        
        splitSubject.sink {[unowned self] value in
            quantityLabel.text = value.stringValue
        }.store(in: &cancellable)
        
    }
    
    public func reset(){
        splitSubject.send(1)
    }
    
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

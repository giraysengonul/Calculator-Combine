//
//  HomeViewController.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit
import SnapKit
import Combine

public final class CalculatorVC: UIViewController {
    
     // MARK: - Properties
    
    private let viewModel: CalculatorVM = .init()
    private var cancellables = Set<AnyCancellable>()
    
    private let logoView: LogoView = LogoView()
    private let resultView: ResultView = ResultView()
    private let billInputView: BillInputView = BillInputView()
    private let tipInputView: TipInputView = TipInputView()
    private let splitInputView: SplitInputView = SplitInputView()
    
    private lazy var vStackView: UIStackView = {
       
        let vStackView: UIStackView = .init(arrangedSubviews: [
            logoView,
            resultView,
            billInputView,
            tipInputView,
            splitInputView
        ])
        vStackView.axis = .vertical
        vStackView.spacing = 24
        return vStackView
    }()
    
    
     // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addConstraint()
        bind()
    }
    
     // MARK: - Helpers
    
    private func bind(){
        
        let input = CalculatorVM.Input(
            billPublisher: billInputView.valuePublisher,
            tipPublisher:  tipInputView.valuePublisher,
            splitPublisher:  splitInputView.valuePublisher)
        let output = viewModel.transform(input: input)
        output.updateViewPublisher.sink {[unowned self] result in
            resultView.configure(result: result)
        }.store(in: &cancellables)
    }
    
    private func setUp(){
        //self
        view.backgroundColor = ThemeColor.bg
    }
    
    private func addConstraint() {
        
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.trailing.equalToSuperview().offset(-16)
            
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        tipInputView.snp.makeConstraints { make in
            make.height.equalTo(56+56+16)
        }
        splitInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
    }
    
}

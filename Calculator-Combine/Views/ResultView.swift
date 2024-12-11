//
//  ResultView.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit

public final class ResultView: UIView {
    
    // MARK: - Properties
    private let headerLabel: UILabel = {
        LabelFactory.build(
            text: "Total p/person",
            font: ThemeFont.demibold(ofSize: 18))
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label : UILabel = .init()
        let text: NSMutableAttributedString = .init(string: "$0", attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(0,1))
        label.attributedText = text
        label.textAlignment = .center
        label.accessibilityIdentifier = ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view: UIView = .init()
        view.backgroundColor = ThemeColor.seperator
        return view
    }()
    
    private lazy var totalBillAmountView: AmountView = {
        let amountView: AmountView = .init(
            title: "Total Bill",
            textAlignment: .left,
            amountLabelIdentifier: ScreenIdentifier.ResultView.totalBillValueLabel.rawValue)
        return amountView
    }()
    
    private lazy var totalTipAmountView: AmountView = {
        let amountView: AmountView = .init(
            title: "Total tip",
            textAlignment: .right,
            amountLabelIdentifier: ScreenIdentifier.ResultView.totalTipValueLabel.rawValue)
        return amountView
    }()
    
    private lazy var hStackView: UIStackView = {
        let hStackView: UIStackView = .init(arrangedSubviews: [
            totalBillAmountView,
            UIView(),
            totalTipAmountView
        ])
        hStackView.axis = .horizontal
        hStackView.distribution = .fillEqually
        hStackView.spacing = 8
        hStackView.alignment = .center
        return hStackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let vStackView: UIStackView = .init(arrangedSubviews: [
            
            headerLabel,
            amountPerPersonLabel,
            horizontalLineView,
            buildspacerView(height: 0),
            hStackView,
            
        ])
        vStackView.axis = .vertical
        vStackView.spacing = 8
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
    
    public func configure(result: Result){
        let text: NSMutableAttributedString = .init(
            string: result.amountPerPerson.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes(
            [.font: ThemeFont.bold(ofSize: 24)],
            range: NSMakeRange(0,1))
        amountPerPersonLabel.attributedText = text
        totalBillAmountView.configure(amount: result.totalBill)
        totalTipAmountView.configure(amount: result.totalTip)
    }
    
    private func setUp(){
        //self
        
        backgroundColor = .white
        addShadow(
            offset: .init(width: 0, height: 3),
            color: .black,
            radius: 12.0,
            opacity: 0.1)
        
    }
    private func addConstraint() {
        
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-24)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        hStackView.snp.makeConstraints { make in
            make.height.equalTo(vStackView.snp.height).multipliedBy(0.30)
        }
        
    }
    
    private func buildspacerView(height: CGFloat) -> UIView{
        let view: UIView = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
}

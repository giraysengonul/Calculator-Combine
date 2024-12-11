//
//  LogoView.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 25.11.2024.
//

import Foundation
import UIKit
import SnapKit

public final class LogoView: UIView {
    
    // MARK: - Properties
    private let logoImageView: UIImageView = {
        let imageView: UIImageView = .init(image: .init(named: "icCalculatorBW"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let topLabel: UILabel = {
        let label: UILabel = UILabel()
        let text: NSMutableAttributedString = .init(string: "Mr TIP", attributes: [.font: ThemeFont.demibold(ofSize: 16)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(3, 3))
        label.attributedText = text
        return label
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(
            text: "Calculator",
            font: ThemeFont.demibold(ofSize: 20),
            textAlignment: .left)
    }()
    
    private lazy var vStackView: UIStackView = {
        let vStackView: UIStackView = .init(arrangedSubviews: [
            topLabel,
            bottomLabel
        ])
        vStackView.axis = .vertical
        return vStackView
    }()
    
    private lazy var hStackView: UIStackView = {
        let hStackView: UIStackView = .init(arrangedSubviews: [
            logoImageView,
            vStackView
        ])
        hStackView.axis = .horizontal
        hStackView.spacing = 5
        hStackView.alignment = .center
        return hStackView
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
        accessibilityIdentifier = ScreenIdentifier.LogoView.logoView.rawValue
        
    }
    private func addConstraint() {
        addSubview(hStackView)
        
        hStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.height.equalTo(logoImageView.snp.width)
        }
        
    }
    
}

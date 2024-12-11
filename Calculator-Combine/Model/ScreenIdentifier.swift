//
//  ScreenIdentifier.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 8.12.2024.
//

import Foundation

@frozen public enum ScreenIdentifier{
    
    public enum LogoView: String{
        case logoView
    }
    
    public enum ResultView: String{
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    public enum BillInputView: String{
        case textField
    }
    
    public enum TipInputView: String{
        case tenPercentButton
        case fiftenPercentButton
        case twentyPercentButton
        case customTipButton
        case customTipAlertTextField
    }
    
    public enum SplitInputView: String{
        case decrementButton
        case incrementButton
        case quantityValueLabel
    }
    
}

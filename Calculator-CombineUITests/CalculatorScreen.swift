//
//  CalculatorScreen.swift
//  Calculator-CombineUITests
//
//  Created by Giray Şengönül on 8.12.2024.
//

import XCTest
@testable import Calculator_Combine

public final class CalculatorScreen{
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    //LogoView
    public var logoView: XCUIElement{
        app.otherElements[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    //ResultView
    public var totalAmountPerPersonValueLabel: XCUIElement{
        app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue]
    }
    
    public var totalBillValueLabel: XCUIElement{
        app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    public var totalTipValueLabel: XCUIElement{
        app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
    
    //BillInputView
    public var billInputViewTextField: XCUIElement{
        app.textFields[ScreenIdentifier.BillInputView.textField.rawValue]
    }
    
    //TipInputView
    public var tenPercentTipButton: XCUIElement{
        app.buttons[ScreenIdentifier.TipInputView.tenPercentButton.rawValue]
    }
    public var fiftenPercentTipButton: XCUIElement{
        app.buttons[ScreenIdentifier.TipInputView.fiftenPercentButton.rawValue]
    }
    public var twentyPercentTipButton: XCUIElement{
        app.buttons[ScreenIdentifier.TipInputView.twentyPercentButton.rawValue]
    }
    public var customTipButton: XCUIElement{
        app.buttons[ScreenIdentifier.TipInputView.customTipButton.rawValue]
    }
    public var customTipAlertTextField: XCUIElement{
        app.textFields[ScreenIdentifier.TipInputView.customTipAlertTextField.rawValue]
    }
    
    //SplitInputView
    public var increamentButton: XCUIElement{
        app.buttons[ScreenIdentifier.SplitInputView.incrementButton.rawValue]
    }
    public var decrementButton: XCUIElement{
        app.buttons[ScreenIdentifier.SplitInputView.decrementButton.rawValue]
    }
    public var quantityValueLabel: XCUIElement{
        app.staticTexts[ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue]
    }
    
    //Actions
    public func enterBill(amount: Double){
        billInputViewTextField.tap()
        billInputViewTextField.typeText("\(amount)\n")
    }
    
    public func selectedTip(tip: Tip){
        switch tip{
        case .tenPercent:
            tenPercentTipButton.tap()
        case .fifteenPercent:
            fiftenPercentTipButton.tap()
        case .twentyPercent:
            twentyPercentTipButton.tap()
        case .custom(value: let value):
            customTipButton.tap()
            XCTAssertTrue(customTipAlertTextField.waitForExistence(timeout: 1.0))
            customTipAlertTextField.typeText("\(value)\n")
        }
    }
    
    public func selectIncreamentButton(numberOfTaps: Int){
        increamentButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    public func selectDecrementButton(numberOfTaps: Int){
        decrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    public func doubleTapLogoView(){
        logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
    
    
    @frozen public enum Tip{
        case tenPercent
        case fifteenPercent
        case twentyPercent
        case custom(Int)
    }
    
    
}

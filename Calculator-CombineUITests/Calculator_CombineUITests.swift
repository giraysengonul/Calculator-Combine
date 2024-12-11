//
//  Calculator_CombineUITests.swift
//  Calculator-CombineUITests
//
//  Created by Giray Şengönül on 25.11.2024.
//

import XCTest

final class Calculator_CombineUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    private var calculatorScreen: CalculatorScreen{
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    public func testResultViewDefaultValue() throws{
        
        XCTAssertEqual(calculatorScreen.totalAmountPerPersonValueLabel.label, "$0")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "$0")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "$0")
        
    }
    
    
    public func testRegularTip() throws{
        
        //User enters a ₺100 bill
        calculatorScreen.enterBill(amount: 100)
        XCTAssertEqual(calculatorScreen.totalAmountPerPersonValueLabel.label, "₺100")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "₺100")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "₺0")
        
        //User selects 10%
        calculatorScreen.selectedTip(tip: .tenPercent)
        XCTAssertEqual(calculatorScreen.totalAmountPerPersonValueLabel.label, "₺110")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "₺110")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "₺10")
        
        //User selects 15%
        calculatorScreen.selectedTip(tip: .fifteenPercent)
        XCTAssertEqual(calculatorScreen.totalAmountPerPersonValueLabel.label, "₺115")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "₺115")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "₺15")
        
        //User selects 20%
        calculatorScreen.selectedTip(tip: .twentyPercent)
        XCTAssertEqual(calculatorScreen.totalAmountPerPersonValueLabel.label, "₺120")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "₺120")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "₺20")
        
        //User splits the bill by 4
        calculatorScreen.selectIncreamentButton(numberOfTaps: 3)
        XCTAssertEqual(calculatorScreen.totalAmountPerPersonValueLabel.label, "₺30")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "₺120")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "₺20")
        
        //User splits the bill by 4
        calculatorScreen.selectDecrementButton(numberOfTaps: 2)
        XCTAssertEqual(calculatorScreen.totalAmountPerPersonValueLabel.label, "₺60")
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "₺120")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "₺20")
        
    }
    
    public func testCustomTipAndSplitBillBy2() throws{
        
        calculatorScreen.enterBill(amount: 300)
        calculatorScreen.selectedTip(tip: .custom(200))
        calculatorScreen.selectIncreamentButton(numberOfTaps: 1)
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "₺500")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "₺200")
        XCTAssertEqual(calculatorScreen.totalAmountPerPersonValueLabel.label, "₺250")
    }
    
    public func testresetButton(){
        
        calculatorScreen.enterBill(amount: 300)
        calculatorScreen.selectedTip(tip: .custom(200))
        calculatorScreen.selectIncreamentButton(numberOfTaps: 1)
        calculatorScreen.doubleTapLogoView()
        XCTAssertEqual(calculatorScreen.totalBillValueLabel.label, "₺0")
        XCTAssertEqual(calculatorScreen.totalTipValueLabel.label, "₺0")
        XCTAssertEqual(calculatorScreen.totalAmountPerPersonValueLabel.label, "₺0")
        XCTAssertEqual(calculatorScreen.billInputViewTextField.label, "")
        XCTAssertEqual(calculatorScreen.quantityValueLabel.label, "1")
        XCTAssertEqual(calculatorScreen.customTipButton.label, "Custom tip")
    }
    
    
    
}

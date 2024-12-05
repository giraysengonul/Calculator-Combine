//
//  Calculator-CombineSnapshotTest.swift
//  Calculator-CombineTests
//
//  Created by Giray Şengönül on 4.12.2024.
//

import XCTest
import SnapshotTesting
@testable import Calculator_Combine

final class CalculatorSnapshotTest: XCTestCase {
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.size.width
    }
    
    public func testLogoView(){
        
        //given
        let size = CGSize(width: screenWidth, height: 48)
        //when
        let view = LogoView()
        //then
        assertSnapshot(of: view, as: .image(size: size))
        
    }
    
    public func testInitialResultView(){
        
        //given
        let size = CGSizeMake(screenWidth, 224)
        //when
        let view = ResultView()
        //then
        assertSnapshots(of: view, as: [.image(size: size)])
        
    }
    
    public func testResultViewWithValues(){
        
        //given
        let size = CGSize(width: screenWidth, height: 224)
        //when
        let result = Result(
            amountPerPerson: 100.25,
            totalBill: 45,
            totalTip: 60)
        let view = ResultView()
        view.configure(result: result)
        //then
        assertSnapshots(of: view, as: [.image(size: size)])
        
    }
    
    public func testBillInputView(){
        
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        //then
        assertSnapshots(of: view, as: [.image(size: size)])
        
    }
    
    public func testBillInputViewWithResult(){
        
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "400"
        //then
        assertSnapshots(of: view, as: [.image(size: size)])
        
    }
    
    public func testInitialTipInputView(){
        
        //given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        //when
        let view = TipInputView()
        //then
        assertSnapshots(of: view, as: [.image(size: size)])
        
    }
    
    public func testInitialTipInputViewWithValues(){
        
        //given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        //when
        let view = TipInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        //then
        assertSnapshots(of: view, as: [.image(size: size)])
        
    }
    
    
    public func testInitialSplitInputView(){
        
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = SplitInputView()
        //then
        assertSnapshots(of: view, as: [.image(size: size)])
        
    }
    
    
    public func testInitialSplitInputViewWithSelection(){
        
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = SplitInputView()
        let button = view.allSubViewsOf(type: UIButton.self).last
        button?.sendActions(for: .touchUpInside)
        //then
        assertSnapshots(of: view, as: [.image(size: size)])
        
    }
    
    
}


extension UIView{
    
    public func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}


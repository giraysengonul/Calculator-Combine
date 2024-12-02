//
//  Calculator_CombineTests.swift
//  Calculator-CombineTests
//
//  Created by Giray Şengönül on 25.11.2024.
//

import XCTest
import Combine
@testable import Calculator_Combine

final class CalculatorVMTests: XCTestCase {

    private var sut: CalculatorVM!
    private var logoViewPublisher: PassthroughSubject<Void, Never>!
    private var cancellable: Set<AnyCancellable>!
    private var audioPlayerService: MockAudioPlayerService!
    
    override func setUp() {
        audioPlayerService = MockAudioPlayerService()
        sut = .init(audioPlayerService: audioPlayerService)
        logoViewPublisher = .init()
        cancellable = .init()
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
     //   audioPlayerService = nil
        sut = nil
        logoViewPublisher = nil
        cancellable = nil
    }
    
    public func testResultWithoutTipFor1Person(){
        
        //given
        
        let bill: Double = 100
        let tip: Tip = .none
        let split: Int = 1
        let input = buildInput(
            bill: bill,
            tip: tip,
            split: split)
        //when
        let output = sut.transform(input: input)
        //then
        
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amountPerPerson, 100)
            XCTAssertEqual(result.totalTip, 0)
            XCTAssertEqual(result.totalBill, 100)
        }.store(in: &cancellable)
     
    }
    
    public func testSoundPlayerCalculatorResetOnLogoViewTap(){
        
        //given
        let input = buildInput(bill: 100, tip: .tenPercent, split: 2)
        let output = sut.transform(input: input)
        let expectation1 = XCTestExpectation(description: "Reset calculator called")
        let expectation2 = audioPlayerService.expectation
        //then
        output.resetCalculatorPublisher.sink { _ in
            expectation1.fulfill()
        }.store(in: &cancellable)
        //when
        logoViewPublisher.send()
        wait(for: [expectation1, expectation2], timeout: 1.0)
        
    }
    
    private func buildInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input{
        return .init(
            billPublisher: Just(bill).eraseToAnyPublisher(),
            tipPublisher: Just(tip).eraseToAnyPublisher(),
            splitPublisher: Just(split).eraseToAnyPublisher(),
            logoViewTapPublisher: logoViewPublisher.eraseToAnyPublisher())
        
    }

}

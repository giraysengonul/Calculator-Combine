//
//  CalculatorVM.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 28.11.2024.
//

import Foundation
import Combine

public final class CalculatorVM{
    
    
    public struct Input{
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Double, Never>
    }
    
    public struct Output{
        let updateViewPublisher: AnyPublisher<Result ,Never>
    }
    
    public func transform(input: Input) -> Output{
        let result = Result(
            amountPerPerson: 500,
            totalBill: 300,
            totalTip: 200)
        
        let output = Output(updateViewPublisher: Just(result).eraseToAnyPublisher())
        
        return output
    }
    
    
}

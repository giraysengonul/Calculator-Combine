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
        let splitPublisher: AnyPublisher<Int, Never>
    }
    
    public struct Output{
        let updateViewPublisher: AnyPublisher<Result ,Never>
    }
    private var cancellable: Set<AnyCancellable> = .init()
    
    public func transform(input: Input) -> Output{
        
        let publishers = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap { [unowned self] (bill,tip,split) in
                let totalTip = getTipAmount(bill: bill, tip: tip)
                let totalBill = bill + totalTip
                let amountPerPerson = totalBill / Double(split)
                let result = Result(
                    amountPerPerson: amountPerPerson,
                    totalBill: totalBill,
                    totalTip: totalTip)
                return Just(result)
                
            }.eraseToAnyPublisher()
        
        let output = Output(updateViewPublisher: publishers.eraseToAnyPublisher())
        
        return output
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double{
        
        switch tip{
            
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(value: let value):
            return Double(value)
        }
        
    }
    
}

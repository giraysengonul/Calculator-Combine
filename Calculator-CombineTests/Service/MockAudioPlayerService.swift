//
//  MockAudioPlayerService.swift
//  Calculator-CombineTests
//
//  Created by Giray Şengönül on 2.12.2024.
//

import Foundation
import XCTest
@testable import Calculator_Combine

public final class MockAudioPlayerService: AudioPlayerService{
    
     // MARK: - Properties
    public var expectation = XCTestExpectation(description: "playSound is called")
    
    
     // MARK: - Init
    public init() {}
    
     // MARK: - Protocol
    
    public func playSound() {
        expectation.fulfill()
    }
    
    
    
}

//
//  TheGiftpireStrikesBackTests.swift
//  TheGiftpireStrikesBackTests
//
//  Created by Theis Egeberg on 11/11/2023.
//

import XCTest
import SwiftUI
@testable import TheGiftpireStrikesBack


final class TheGiftpireStrikesBackTests: XCTestCase {
    
    
    class PowerConverter {
        var powerRating = 2
        var turbo:Int? = 2
        
        init(int: Int = 2, optionalInt: Int? = nil) {
            self.powerRating = int
            self.turbo = optionalInt
        }
        
    }
    
    func testPowerConverter() {
        let object = PowerConverter(int: 10, optionalInt: nil)
        
        let binding:Binding<Int?> = Binding {
            object.turbo
        } set: {
            object.turbo = $0
        }
        XCTAssertEqual(object.turbo, nil)
        binding.wrappedValue = 2
        XCTAssertEqual(object.turbo, 2)
        let twirled = binding.flipOptionality()
        XCTAssertEqual(twirled!.wrappedValue, 2)
        binding.wrappedValue = nil
        let twirled2 = binding.flipOptionality()
        XCTAssertNil(twirled2)
    }
    
    func testContrabandIdentification() {
        let wine = Wine(color: .red, year: 1980, castle: "Chatea VeryOld'o")
        let chocolate = Chocolate(brand: "Ritter", cocoaPercentage: 20, nuts: [.almond], raisins: true)
        let wineGift = Gift.wine(wine)
        let chocolateGift = Gift.chocolate(chocolate)
        XCTAssertEqual(wine.id, wineGift.id)
        XCTAssertEqual(chocolate.id, chocolateGift.id)
    }

}

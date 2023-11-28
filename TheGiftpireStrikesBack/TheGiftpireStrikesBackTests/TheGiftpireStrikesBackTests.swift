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
        
        init(powerRating: Int = 2, turbo: Int? = nil) {
            self.powerRating = powerRating
            self.turbo = turbo
        }
        
    }
    
    func testProblemWithPowerConverters() {
        let object = PowerConverter(powerRating: 10, turbo: 100)
        
        let binding:Binding<Int?> = Binding {
            object.turbo
        } set: {
            object.turbo = $0
        }
        
        binding.wrappedValue = 1000
        XCTAssertNotNil(binding.wrappedValue)
        let twirl = binding.flipOptionality()
        XCTAssertNotNil(twirl)
        binding.wrappedValue = nil
        
        
    }
    
    func testPowerConverter() {
        let object = PowerConverter(powerRating: 10, turbo: 100)
        
        let binding:Binding<Int?> = Binding {
            object.turbo
        } set: {
            object.turbo = $0
        }
        
        binding.wrappedValue = 10
        let twirled:Binding<Int>? = binding.flipOptionality()
        binding.wrappedValue = 20
        XCTAssertNotNil(twirled)
        XCTAssertEqual(twirled?.wrappedValue, 20)
        
    }
    
    func testContrabandIdentification() {
        let wine = Wine(color: .red, year: 1980, castle: "Chatea VeryOld'o")
        let chocolate = Chocolate(brand: "Ritter", cocoaPercentage: 20, nuts: [.almond], raisins: true)
        let wineGift = Gift.wine(wine)
        let chocolateGift = Gift.chocolate(chocolate)
        XCTAssertEqual(wine.id, wineGift.id)
        XCTAssertEqual(chocolate.id, chocolateGift.id)
    }
    
    func testNewBindings() {
        /// Hmm looks like someone didn't care too much about
        /// variable naming. I wonder if it was to avoid cheating.
        var a = Gift.wine(.dessert)
        var b = Gift.chocolate(.lindt90)
        XCTAssertNil(a.chocolate)
        XCTAssertNil(b.wine)
        XCTAssertNotNil(a.wine)
        XCTAssertNotNil(b.chocolate)
        let c = Binding {
            a
        } set: { newValue in
            a = newValue
        }
        XCTAssertNil(c.chocolateBinding)
        XCTAssertNotNil(c.wineBinding)
        let d = Binding {
            b
        } set: { newValue in
            b = newValue
        }
        XCTAssertNil(d.wineBinding)
        XCTAssertNotNil(d.chocolateBinding)
        XCTAssertEqual(b.title, Chocolate.lindt90.brand)
        d.wrappedValue = .chocolate(.ritterRumRaisins)
        XCTAssertEqual(b.title, Chocolate.ritterRumRaisins.brand)
    }

}

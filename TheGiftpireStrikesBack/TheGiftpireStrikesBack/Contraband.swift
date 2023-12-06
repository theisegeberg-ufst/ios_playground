import SwiftUI
import Foundation

enum Nut {
    case almond, pecan
}

func randomIdentifier(count: Int = 5) -> String {
    .init((0..<count).map { _ in "ABCDEFGHIJKLMNOPQRSTUVWXYZ".randomElement() ?? "0" })
}

struct Chocolate: Identifiable {
    let id: String = randomIdentifier()
    var brand:String
    var cocoaPercentage:Int
    var nuts:[Nut]
    var raisins:Bool
    
    static let lindt90 = Chocolate(brand: "Lindt", cocoaPercentage: 90, nuts: [], raisins: false)
    static let ritterRumRaisins = Chocolate(brand: "Ritter Sport", cocoaPercentage: 40, nuts: [.almond], raisins: true)
    
}

struct Wine: Identifiable {
    
    enum WineColor:String {
        case red, white
    }
    
    let id: String = randomIdentifier()
    var color:WineColor
    var year:Int
    var castle:String
    
    static let dracula = Wine(color: .red, year: 2004, castle: "Chateau de Sang")
    static let dessert = Wine(color: .white, year: 1994, castle: "Castel de Lago")
    
}

extension Gift {
    #warning("Task 1")
    /// The smugglers have a problem, they need to quickly unwrap the gifts, so can you
    /// please add quick access to the contents.
    var chocolate: Chocolate? {
        switch self {
        case .wine:
            return nil
        case .chocolate(let chocolate):
            return chocolate
        }
    }
    
    var wine: Wine? {
        switch self {
        case .wine(let wine):
            return wine
        case .chocolate:
            return nil
        }
    }
}

#warning("Task 2")
/// Well this is well broken. But using the tools we've built
/// perhaps we can build bindings for chocolate and wine in here.
extension Binding where Value == Gift {
    
    var chocolateBinding: Binding<Chocolate>? {
        self.map {
            $0.chocolate
        } wrap: {
            Gift.chocolate($0)
        }
        .flipOptionality()
    }
    
    var wineBinding: Binding<Wine>? {
        self.map {
            $0.wine
        } wrap: {
            Gift.wine($0)
        }
        .flipOptionality()
    }
}


enum Gift:Identifiable {
    
    var title: String {
        switch self {
        case .wine:
            fatalError("What should the title be for wine? 🤓")
        case .chocolate(let chocolate):
            chocolate.brand
        }
    }

    var id:String {
        switch self {
        case .wine(let wine):
            wine.id
        case .chocolate(let chocolate):
            chocolate.id
        }
    }
    
    case wine(Wine)
    case chocolate(Chocolate)
}


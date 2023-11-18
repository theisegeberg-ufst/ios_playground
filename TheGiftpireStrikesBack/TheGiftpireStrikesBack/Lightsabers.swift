
import SwiftUI
import Combine

#warning("Lukes x-wing is out of the swamp, but he needs to fix the engine")
/// The force is strong in you, but we've got a slight problem getting the x-wing to fly.
/// We'll need to invert the flow of energy in the engines first. It's a classic T-65B model, so it
/// should be fairly simple.
///
/// The Novaldex 04-Z cryogenic power generator is located towards the end of the ship.
///
/// Have a look below, we've got an unwrapping and wrapping map of a Binding. That'll be useful later
/// but first we'll need to fit with the other engine parts. To do that I need to flip its optionality. Uhuh?
/// You've never flipped the optionality of a monad before?! Ok well it goes like this...
/// Monad<Wrapped?> becomes Monad<Wrapped>?

extension Binding {
    func map<T>(unwrap: @escaping (Value)->T?, wrap: @escaping (T)->Value) -> Binding<T?> {
        return .init {
            unwrap(self.wrappedValue)
        } set: { newValue in
            guard let newValue else {
                return
            }
            self.wrappedValue = wrap(newValue)
        }
    }
    
    func flipOptionality%€ÆÆÆ-.() -> ::EEF: :F FESFS {
        // Oh dear, something seems to be broken here
        #warning("This is all wrong")
    }
}

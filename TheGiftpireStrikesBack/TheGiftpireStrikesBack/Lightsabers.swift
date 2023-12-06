
import SwiftUI
import Combine

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
    
    func flipOptionality<T>() -> Binding<T>? where Value == Optional<T> {
        guard self.wrappedValue != nil else { return nil }
        return Binding<T>(
            get: { self.wrappedValue! },
            set: { newValue in
                self.wrappedValue = newValue
            }
        )
    }
}

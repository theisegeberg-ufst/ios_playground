enum Either<A,B> {
    case a(A)
    case b(B)
    var flipped:Either<B,A> {
        switch self {
        case .a(let a):
                .b(a)
        case .b(let b):
                .a(b)
        }
    }
}

extension Either {
    var a:A? {
        switch self {
        case .a(let a):
            a
        case .b:
            nil
        }
    }
    
    var b:B? {
        switch self {
        case .b(let b):
            b
        case .a:
            nil
        }
    }
}

extension Either where A == B {
    var value:A {
        switch self {
        case .a(let a), .b(let a):
            a
        }
    }
}

extension Either {
    func flatMap<C>(_ ac:(A)->(Either<C,B>)) -> Either<C,B> {
        switch self {
        case .a(let a):
            ac(a)
        case .b(let b):
                .b(b)
        }
    }
    
    // Higher order functions are functions that either takes as input a function or gives as output a function.
    func flatmap<C>(_ bc: (B)->(Either<A,C>)) -> Either<A,C> {
        flipped.flatMap { b in bc(b).flipped }.flipped
    }
    
    func map<C>(_ ac:(A)->C) -> Either<C,B> {
        flatMap { a in .a(ac(a)) }
    }
}

import Cocoa

enum SquareRootError: LocalizedError {
    case outOfBounds, noRoot
    
    var errorDescription: String? {
           switch self {
           case .outOfBounds:
               return NSLocalizedString("OutOfBounds", value: "Out of bounds value as input. Provide a value of 1 to 10,000", comment: "")
           case .noRoot:
               return NSLocalizedString("NoRoot", value: "The input value is not a perfect square. Try another value; e.g. 9", comment: "")
           }
       }
}

func squareRoot(of: Int) throws -> Int {
    if of < 1 || of > 10_000 {
        throw SquareRootError.outOfBounds
    }
    
    for i in 1...10_000 {
        if i * i == of {
            return i
        }
    }
    
    throw SquareRootError.noRoot
}


do {
    let n = -5
    let r = try squareRoot(of: n)
    print("Square Root of \(n) is \(r)")
} catch {
    print("Error: \(error.localizedDescription)")
}

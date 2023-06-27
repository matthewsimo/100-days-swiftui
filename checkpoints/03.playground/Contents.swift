import Cocoa

for i in 1...100 {
    switch i {
    case let x where x.isMultiple(of: 5) && x.isMultiple(of: 3):
        print("FizzBuzz: \(i)")
    case let x where x.isMultiple(of: 3):
        print("Fizz: \(i)")
    case let x where x.isMultiple(of: 5):
        print("Buzz: \(i)")
    default:
        print(i)
    }
}

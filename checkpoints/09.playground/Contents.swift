import Cocoa

func getRandom(from: [Int]?) -> Int {
    from?.randomElement() ?? Int.random(in: 1...100)
}

print(getRandom(from: nil))
print(getRandom(from: [1, 2, 3, 4,5]))
print(getRandom(from: [3, 6, 9]))

import Cocoa


protocol Building {
    var rooms: Int { get }
    var cost: Int { get set }
    var agent: String { get set }
    
    func printSummary () -> Void
}

extension Building {
    func printSummary() {
        print("Rooms: \(rooms)")
        print("Cost: \(cost)")
        print("Agent: \(agent)")
    }
}

struct House: Building {
    var rooms: Int
    var cost: Int
    var agent: String
}

extension House {
    init(rooms: Int, cost: Int) {
        self.rooms = rooms
        self.cost = cost
        self.agent = "Jimmy"
    }
}

struct Office: Building {
    var rooms: Int
    var cost: Int
    var agent: String
    
}

extension Office {
    init(rooms: Int, cost: Int) {
        self.rooms = rooms
        self.cost = cost
        self.agent = "James"
    }
}


let house = House(rooms: 8, cost: 300_000)
house.printSummary()

print("-------")

let office = Office(rooms: 40, cost: 2_500_000)
office.printSummary()


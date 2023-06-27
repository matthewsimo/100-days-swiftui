import Cocoa


struct Car {
    let model: String
    let seatCount: Int
    
    private(set) var currentGear: Int
    
    enum ShiftOption {
        case Up, Down
    }
    
    mutating func shiftGear(direction: ShiftOption) -> Bool {
        if(direction == .Up && currentGear < 10) {
            currentGear += 1
            return true
        }
        
        if(direction == .Down && currentGear > 1) {
            currentGear -= 1
            return true
        }
        
        return false
    }
    
    init(model: String, seatCount: Int) {
        self.model = model
        self.seatCount = seatCount
        currentGear = 1
    }
}

var car1 = Car(model: "Tesla", seatCount: 4)
var car2 = Car(model: "Subaru", seatCount: 4)

print(car1)
print(car2)

car1.shiftGear(direction: .Up)
car1.shiftGear(direction: .Up)
car1.shiftGear(direction: .Up)
car1.shiftGear(direction: .Down)
car1.shiftGear(direction: .Down)
car1.shiftGear(direction: .Down)
car1.shiftGear(direction: .Down)
car1.shiftGear(direction: .Down)
car1.shiftGear(direction: .Down)
car1.shiftGear(direction: .Down)
car1.shiftGear(direction: .Up)

car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Up)
car2.shiftGear(direction: .Down)
car2.shiftGear(direction: .Up)

print(car1)
print(car2)

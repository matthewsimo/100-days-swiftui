import Cocoa


class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}


class Dog: Animal  {
    func speak() {
        print("woof woof")
    }
    
    init() {
        super.init(legs: 4)
    }
}

class Corgi: Dog {
    override func speak() {
        print("woof woof, I'm a corgi")
    }
}

class Poodle: Dog {
    override func speak() {
        print("woof woof, I'm a poodle")
    }
}


class Cat: Animal {
    let isTame: Bool
    
    func speak() {
        print("meow meow")
    }
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
}

class Persian: Cat {
    override func speak() {
        print("meow meow, I'm a persian")
    }
    
    init() {
        super.init(isTame: true)
    }
}

class Lion: Cat {
    override func speak() {
        print("roar roar, I'm a lion")
    }
    
    init() {
        super.init(isTame: false)
    }
}


let dog1 = Corgi()
let dog2 = Poodle()
let cat1 = Persian()
let cat2 = Lion()

dog1.speak()
dog2.speak()
cat1.speak()
cat2.speak()

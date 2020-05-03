import UIKit

// Day 10 – classes and inheritance
class Dog {
    var name: String
    var breed: String
    
    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let puppy = Dog(name: "Cristal", breed: "BB")

// inheritance
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}

// Method override
class Dog2 {
    func makeNoise() {
        print("Woof!")
    }
}

class Poddle2: Dog2 {
}

let puppy2 = Poddle2()
puppy2.makeNoise()

class Poddle3: Dog2 {
    override func makeNoise() {
        print("Yip!")
    }
}

let puppy3 = Poddle3()
puppy3.makeNoise()

// Final classes
// Cannot be a super class. Must be used as is
final class Dog4 {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

// Copying objects
class Singer {
    var name = "Taylor Swift"
}

// Works as a pointer
var singer = Singer()
print(singer.name)

var singerCopy = singer
singerCopy.name = "Justin Bieber"
print(singer.name)

// Deinit
class Person2 {
    var name = "John Doe"

    init() {
        print("\(name) is alive!")
    }
    
    // Called when the object is destroyed
    deinit {
        print("\(name) is no more!")
    }

    func printGreeting() {
        print("Hello, I'm \(name)")
    }
}

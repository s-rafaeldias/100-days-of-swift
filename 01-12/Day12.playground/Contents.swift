import UIKit

// Handling missing data
var age: Int? = nil
// This gives an error
// var age: Int = nil


// Unwrapping optionals
var name: String?

if let value = name {
    print("\(value.count) letters")
} else {
    print("Missing name")
}


// Unwrapping with guard
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    
    print("Hello, \(unwrapped)")
}

greet("Rafael")
greet(nil)


// Force unwrapping
let str = "5"

let num = Int(str)
type(of: num)

let num2 = Int(str)!
type(of: num2)


// Nil coalescing
func username(for id: Int) -> String? {
    if id == 1 {
        return "Taylor Swift"
    } else {
        return nil
    }
}

let user = username(for: 15) ?? "Anonymous"


// Optional chaining
let names = ["John", "Paul", "George", "Ringo"]
var beatle = names.first?.uppercased()

let names2: [String] = []
beatle = names2.first?.uppercased()


// Optional try
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

// Better solution
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh")
}

// NOT SAFE
try! checkPassword("sekrit")
print("OK!")


// Failable initializers
struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}


// Typecasting
class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}
let pets = [Fish(), Dog(), Fish(), Dog()]

for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

// Lesson Three

// Closures

let c = { print("hi!") }
c()

let p = { (thing: String) -> () in
    print(thing)
}
p("hi!")

let double = { (thing: String) -> String in
    return "\(thing) \(thing)"
}
double("hi!")

let range = 0..<10

range.forEach({ (number: Int) -> () in
    print(number)
})

range.forEach { (number: Int) -> () in
    print(number)
}

range.forEach { print($0) }

let numbers = range.map { "\($0)" } // infered return value
numbers


(0...10).reduce(0, combine: { $0 + $1} )

func add(lhs: Int, rhs: Int) -> Int { return lhs + rhs }
(0...10).reduce(0, combine: add)

[5,1,88, 3, -100, 44].reduce(Int.min, combine: max)

[5,1,88, 3, -100, 44].sort(<)


// Lazy Computed Properties

struct Person {
    let firstName: String
    let lastName: String

    lazy var fullName: String = {
        return "\(self.firstName) \(self.lastName)"
    }()

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

var orta = Person(firstName: "Orta", lastName: "Therox")
orta.fullName

// Protocols



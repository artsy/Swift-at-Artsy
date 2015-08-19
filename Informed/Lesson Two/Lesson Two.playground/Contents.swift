import Cocoa

/*

Structs and classes

*/

struct Artist {
    let name: String
}

let artist = Artist(name: "Orta")

struct Artwork {
    let name: String
    let artist: Artist

    var artistName: String {
        return artist.name
    }
}

class MyClass {
    var property = ""
}

struct MyStruct {
    var property = ""
}

var a = MyClass()
var b = MyStruct()

a.property = "Hi"
b.property = "Hi"

a.property
b.property

var a2 = a
var b2 = b

a2.property = "Hello"
b2.property = "Hello"

a.property
b.property



/*

Enums

*/

enum MyEnum {
    case FirstOption, SecondOption
    case ThirdOption
}

let e = MyEnum.FirstOption

switch e {
case .FirstOption:
    print("first")
case .SecondOption:
    print("second")
case .ThirdOption:
    print("third")
}


enum MyIntEnum: Int {
    case FirstOption = 0
    case SecondOption // inferred to be 1, and so on
    case ThirdOption
}

print(MyIntEnum.FirstOption.rawValue)

if let value = MyIntEnum(rawValue: 0) {
    // value is now a (non-optional) MyIntEnum
}

enum MyStringEnum: String {
    case FirstOption
}

print(MyStringEnum.FirstOption.rawValue)


enum Result {
    case Success
    case Failure(reason: String)
}

func performAction(input: Int) -> Result {
    if input == 0 {
        return .Failure(reason: "Invalid input")
    } else {
        return .Success
    }
}

switch performAction(0) {
case .Success:
    print("Success!")
case .Failure(let reason):
    print("Failure: \(reason)")
}



/*

Tuples

*/

let tuple = ("This is a value", 1)
tuple.0 // "This is a value"
tuple.1 // 1

let namedTuple = (stringValue: "This is a value", intValue: 1)
namedTuple.stringValue // "This is a value"
namedTuple.intValue // 1



/*

Generics

*/

func doSomething<T>(input: T) -> T {
    return input
}

doSomething("hi")
doSomething(1234)
doSomething([1,2,3,4])

struct Stack<T> {
    private var contents = Array<T>()

    mutating func push(input: T) {
        contents.append(input)
    }

    mutating func pop() -> T? {
        return isEmpty() ? nil : contents.removeFirst()
    }

    func isEmpty() -> Bool {
        return contents.count == 0
    }
}

var stack = Stack<Int>()
stack.push(1) // Error!
stack.pop()

enum AssociatedResult<T> {
    case Success(result: T)
    case Failure(reason: String)
}





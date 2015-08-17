//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

1 + 2
1/2
1.0/2.0

str = "Artsy"

"Hello, Artsy"

"Hello, \(str)"

// This breaks the static type-checker
//var myString: String = 1

// This breaks constant re-assignment
//let constant = "Constant"
//constant = "new value"

let name: String
let someCondition = true

if someCondition {
    name = "Ash"
} else {
    name = "Orta"
}

print(name)

for var i = 0; i < 10; i++ {
    print("Hi: \(i)")
}

for i in 0..<10 {
    print("Hi: \(i)")
}

func translate(english: String) -> String? {
    switch english.lowercaseString {
    case "hi":
        return "Bonjour"
    case "what time is it?":
        return "Quelle heur fait-il?"
    default:
        return nil
    }
}

if let translatedString = translate("Hi") {
    print("Translated as '\(translatedString)'")
} else {
    print("Translation failed, contact support.")
}





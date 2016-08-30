import Foundation

enum PlayerChoice {
    case Rock
    case Paper
    case Scissors
}

print("Hello, World!")
print("> ", separator: "", terminator: "")

print(")

//let response = readLine(stripNewline: true)
//if let answer = response {
//    print("You said: \(answer)");
//}


func randomChoice() -> PlayerChoice {
    switch arc4random() % 3 {
    case 1: return .Rock
    case 2: return .Paper
    default: return .Scissors
    }
}

randomChoice()
randomChoice()
randomChoice()
randomChoice()
randomChoice()
randomChoice()
randomChoice()


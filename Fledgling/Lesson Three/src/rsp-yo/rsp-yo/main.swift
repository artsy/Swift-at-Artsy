import Foundation

enum PlayerChoice {
    case Rock
    case Paper
    case Scissors
}

print(" ")
print("____________________  _________                           ")
print("\\______   \\______   \\/   _____/            ___.__. ____   ")
print(" |       _/|     ___/\\_____  \\    ______  <   |  |/  _ \\  ")
print(" |    |   \\|    |    /        \\  /_____/   \\___  (  <_> ) ")
print(" |____|_  /|____|   /_______  /            / ____|\\____/  ")
print("        \\/                  \\/             \\/             ")
print(" ")

func randomChoice() -> PlayerChoice {
    switch arc4random() % 3 {
    case 1: return .Rock
    case 2: return .Paper
    default: return .Scissors
    }
}

let computerChoice = randomChoice()

print("What do you choose [R]ock, [P]aper, [S]issors?")

func getPlayerChoice() -> PlayerChoice? {
    print("> ", separator: "", terminator: "")
    let response = readLine(stripNewline: true)
    if let answer = response {
        if let choice = answer.lowercaseString.characters.first {
            print("You said: \(choice)")
            if choice == "r" {
                return .Rock
            }
            if choice == "s" {
                return .Scissors
            }
            if choice == "p" {
                return .Paper
            }
            print("This is not a valid choice, please choose again.")
        }
    }
    return nil
}

var choice: PlayerChoice?
while choice == nil {
    choice = getPlayerChoice()
}

let youWon = choice! == .Rock && computerChoice == .Scissors ||
             choice! == .Scissors && computerChoice == .Paper ||
             choice! == .Paper && computerChoice == .Rock

let youLose = choice! == .Rock && computerChoice == .Paper ||
              choice! == .Scissors && computerChoice == .Rock ||
              choice! == .Paper && computerChoice == .Scissors


if youWon {
    print("You won!")
} else if youLose {
    print("You lost!")
} else {
    print("It's a draw!")
}

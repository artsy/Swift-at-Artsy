import Foundation

print("Hello, World!")
print(">", separator: "", terminator: "")

let response = readLine(stripNewline: true)

if let answer = response {
    print("You said: \(answer)");
}
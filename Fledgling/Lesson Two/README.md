# Lesson Two 

We're going to make a command line application. From scratch. It's all going to come to 9 lines of code. This is code that I wrote without thinking "this is aimed at fledglings" - so there's quite a few concepts in here that are new to you. This means it's closer to production code, which ideally we want to be able to read/write as we are fledgling engineers. 

🐦

I think we can quite happily spend an hour just discussing those 9 lines. Here they are, for some forshadowing. 

```swift
import Foundation

print("Hello, World!")
print("> ", separator: "", terminator: "")

let response = readLine(stripNewline: true)
if let answer = response {
    print("You said: \(answer)");
}
```

### Xcode

* Create a new Project
* Show how to run the build

### Import

* Discuss what import is
* Show where `print` comes from

### Optional Parameters

* Show how `print` can be both `print("Hello, World!")` and `print("> ", separator: "", terminator: "")`
* Cover how that allows you to have more expressive & succinct functions 

### Letting things be

* Talk about `let`
* Discuss the ideas of mutable vs immutable

### if let this = that

* Discuss optionals - think of an example that can be true/false and unknown.
* Cover this use case like this one:
  - What if you're running inside a place where you cannot use a keyboard?

### Running our app

* Talk about the idea of compilers, and build artifacts
* Open terminal
* Show how to run our app from the terminal

### Expanding out

* Make a simple calculator if there is time.
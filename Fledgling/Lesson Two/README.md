# Lesson Two 

We're going to make a command line application. From scratch. It's all going to come to 9 lines of code. This is code that I wrote without thinking "this is aimed at fledglings" - so there's quite a few concepts in here that are new to you. This means it's closer to production code, which ideally we want to be able to read/write as we are fledgling engineers. 

🐦

I think we can quite happily spend an hour just discussing those 9 lines. Here they are, for some foreshadowing. 

```swift
import Foundation

print("Hello, World!")
print("> ", separator: "", terminator: "")

let response = readLine(stripNewline: true)
if let answer = response {
    print("You said: \(answer)");
}
```

Basically I want to have it say hello, then answer back whatever I told it.

### Xcode

To get started we need to create a new project. Open up Xcode and you will be presented by this window.

![images/xcode-start.png](images/xcode-start.png)

Click on "Create a New Xcode Project" to choose the type of project. We want to make an `OS X` `Application`, that is a `Command Line Tool`.

 ![images/xcode-commandline.png](images/xcode-commandline.png)

Choosing this brings up a form, you can call it what you like, I'm calling mine "HelloWorld." The only other thing that is important here, is that you change the language to Swift. This isn't learn Objective-C at Artsy - 'ya know. 

This gives us a full Xcode project that creates an app that runs inside a terminal. To run it either click the play button in the top left, or press `cmd` + `r`. The output of `print` will show along the bottom.

![images/xcode-run.png](images/xcode-run.png)

### Import

OK, we've said ignore the `import` enough times. Let's dig into this. 

So, last time we talked a little bit about non-trivial Objects (this wasn't noted, we looked into the [NSDate](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSDate_Class/index.html) class) These objects are made up from the types that we've been playing with: `Int`s, `String`s, `Array`s, `Bool`s. 

We call the Types that are included inside Swift, the "Standard Library." These are the effectively building blocks of all other Types. However, it's hard to create an application with just numbers and strings. So, we bundle collections of related objects together into libraries or frameworks.

Apple provides a set of libraries for you to use, in this case, there is one called `Foundation`. `Foundation` provides `NSDate` for dates, `NSFileManager` for getting information in/out of the file system, `NSTask` for running command line tasks, `NSURL` for representing a URL and a lot more. These are all considered foundational tools. 

Separate from `Foundation` is `Cocoa` or `UIKit` - these provide all of the user interface objects, which we may touch on later in the week.

This is a perfect point to pitch what CocoaPods is. CocoaPods is a way of using other people' libraries. So, in the Artsy app we have code from Facebook, GitHub and many individual developers from around the world. We use the `import` statement to bring in their code into our apps, and CocoaPods is the glue that makes all that work.

This means we can work on the shoulders of others, and we give back, so others can work from our shoulders.

### Optional Parameters

OK, so I want it to print `hello world`, which is it doing, but then I want to make it obvious that we expect some user input. I can do this by printing something and _not_ having it add a newline at the end of the print statement.

I initially searched online for a way to do this, and was pleasantly surprised by how you do it. You use the same function, it's just that it has default parameters that I didn't know about.

So how does this work?

If you hold `cmd` and click on `print` - you see this:

```swift
print(items: Any..., separator: String = default, terminator: String = default)
```

This tells us that the `print` method takes `Any` type of object and the `...` means that it can take as  many as you want to give it. Then it has two more parameters.  `separator: String = default` and `terminator: String = default`. As this is the function definition, not the function, we don't have access to _what_ the default is, just that there is one. 

So let's write our own function to show how it works.

```swift
func showArtworkDetails(title: String, price:String, showPrice: Bool = true) {
  print(title)
  if showPrice {
    print(price)
  }
} 
``` 

Nearly all of the time you want to show the price, so you would write `showArtworkDetails("My Work", price: "$45")` however, when you don't want to show the price, you can add an extra parameter to override the default: `showArtworkDetails("My Work", price: "$45", showPrice: false)`.

So default parameters can help you set the common case parameters, but let people change them if they choose. So in our case, nearly all of the time you want to `print` you want an end of line. However, we want to not have it, so we change the default parameter: `print("> ", separator: "", terminator: "")`.

### Letting things be

So we want to get user input, `readLine(stripNewline: true)` is the line of code we want. We want to assign this into a variable. However, well, we're going to write `let` instead of `var` which we have done throughout the course so far. We've done that because `var` matches closer to the terminology are using. Real-world though, we strive to use `let` instead of `var` everywhere.

So what's the difference?

This is fine with a `var`:

```swift
var isArtworkSold = true
// Something happens
isArtworkSold = false
```

This is not fine with a `let`:

```swift
let isArtworkOnHold = true
// Something happens
isArtworkOnHold = false # compiler error
```

The code that we have wrote on the Artsy iOS app is roughly 40k LOC, when you make an edit anywhere, you want to be sure that those changes only affect the things you want. One way to do this, is to say "this thing can only be changed once."

We call this immutability, in that something cannot mutate. It's a promise that something will not change in the future. If something cannot change then it requires less thinking about. Swift lets you declare that somethign won't change. So in this case, once we have got the user input, we cannot ever change what that variable is. It will always be that string.

### if let this = that

So, we want to print out this string. However, it's not that simple. If we look at `readLine`, we see something new:

```swift
public func readLine(stripNewline stripNewline: Bool = default) -> String?
```

This returns a `String?` so what is a `String?`? Well, we would call this an `String` `Optional` out loud. It means it _could_ be a `String` but it also could not. We just don't know.

The problem for `readLine` is that it might not always be able to connect to a keyboard input. For example if it is running on a server in the cloud. No keyboards there. So in those cases it would return something that represents nothing: `nil`. 

This is not the same as `false`. You could have a `Bool?` which represents an `Bool Optional`, having three states: `nil`, `true`, `false`. E.g. Is it Banksy's birthday? Well if you know the person you can say yes or no, but if not then you don't know - so it's nil.

So we need to check if we've recieved a `nil` value, 

### Running our app

* Talk about the idea of compilers, and build artifacts
* Open terminal
* Show how to run our app from the terminal

### Expanding out

* Make a simple calculator if there is time.

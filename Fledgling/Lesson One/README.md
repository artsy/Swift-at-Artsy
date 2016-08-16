# Alright - welcome to year 2.

To start, this will be a re-cap of what we studied a year ago in the [Beginners course](../../Beginners).

You can copy along this by opening Xcode:

![Xcode Welcome Screen](../../Beginners/Lesson%20One/img/welcome.png)

and creating a new playground:

![Creating a new playground](../../Beginners/Lesson%20One/img/newplayground.png)

Awesome. Xcode will create an open the playground for you. It'll look something like this. 

![Empty Playground](../../Beginners/Lesson%20One/img/emptyplayground.png)

### Variables and Base Types

Lets cover the base types again. Things like strings, numbers and functions

```swift
// A variable called thing, that has a String inside, 
// which represents the words: Hello, world
var thing = "Hello, world" 

// vars can be changed
thing = "Hello, orta"

// but vars cannot change types, this won't work
// things = 123

1 + 1
2 / 3
2.0 / 4.0
```

There's things like the `if` which run code only when something specific has happened, 
try changing `var shouldShowViewInRoom = false` to `var shouldShowViewInRoom = true` to see.

```swift
var shouldShowViewInRoom = false

if shouldShowViewInRoom {
  print("Add the VIR button.")
}
```

There are functions too, which let you store some code to run later:

```swift
// you can declare a function, that prints the String: do something 
func printSomething() {
  print("do something")
}

// then call it later
printSomething()
```

Or they can return a value:

```swift
// we use -> to say, it will return the type String 
func firstName() -> String {
  return "Danger"
}

// then call it to set a string var
var name = firstName()
```

They can contain parameters, things that go into the function. The
names that you give them are names for the `var`s inside the block of code 

```swift
// this function takes two Strings in, and returns a new String 
func fullName(firstName: String, lastName: String) -> String {
  return "\(firstName) \(lastName)"
}

// calls the fullName function
fullName("Danger", lastName:"McShane")
```

### We can make our own Types

You can do a lot with just the base types, but realistically, you're going
to need to create your own eventually to describe your own data. So, lets
cover what an Artist would look like in Swift.

First we have to declare a prototype for what a type looks like, then we can 
create one by using it's name as a function.

```swift
// Define what an Artist looks like
struct Artist {
    var name: String
    var location: String
}

// Create a banksy, and check out it's name / location 
var banksy = Artist(name: "Banksy", location: "U.K.")
banksy.name
banksy.location
```  

### Making Types do work

So, it makes sense to let a type not just hold data, it can do
work on the data that it holds.

```swift
// Define what an Artwork looks like
struct Artwork {
    var name: String
    var medium: String
    var artist: Artist

    func printArtworkTitle() {
      print("\(name), \(medium) by \(artist.name)")
    }
}

var balloon = Artwork(name: "Girl with Balloon", medium: "Screenprint", artist: banksy)
balloon.name
balloon.printArtworkTitle()
```

So lets learn something new. A prototype for a class is created, is not done. You can actually
make changes to the type at another point in the code.

```swift
// Take an Artwork, and add a new function to it
extension Artwork {
    func printTitle() {
        printArtworkTitle()
        print("by \(artist.name)")
    }
}

// call our new function on the existing balloon artwork we created earlier
balloon.printTitle()
 ```

Can you think of ways in which this could be useful?


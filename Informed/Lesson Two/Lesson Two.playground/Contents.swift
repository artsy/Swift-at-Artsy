//: # Lesson Two
//: 
//: Welcome back! Last time, we took a look at Swift's syntax and Xcode playgrounds. We touched _very_ briefly on the idea of types.
//: 
//: Swift is a _strongly typed language_ and the type system is very robust. Combined with type inference, you can write expressive code without being repetitive. Many languages might define an integer variable as `int i = 0`, but in Swift, it's just `var i = 0`, and Swift figures out that `0` is an integer.
//: 
//: In this lesson, we're going to take a whirlwind tour through Swift's different types:
//: 
//: - Structs
//: - Classes
//: - Enums
//: - Tuples
//: 
//: Finally, we'll take a deeper look at generics. Let's get started!
//: 
//: ----------------
//: 
//: **Structs** in Swift are containers for other data, similar to structs in C. Structs can hold integers, strings, arrays, other structs – anything!
//: 
//: This is a simple Swift struct.
struct Artist {
  let name: String
}
//: In this case, the `Artist` struct has one _property_. Properties are values stored within the struct and accessed with dot notation: `instance.property = whatever`. The property we've defined on `Artist` is called `name` and it's a `String` type. It's not an optional, so it can't be `nil`, and it's declared with `let`, so it cannot be changed after an `Artist` instance is created.
//: 
//: Swift structs can also have functions in them. That might seem strange, but that's OK. We'll cover that shortly.
//: 
//: Once we have our `Artist` struct above, how can we instantiate it? Well, Swift provides structs with default initializers – sometimes called constructors. To create an artist, you'd do the following.
let artist = Artist(name: "Orta")
//: Very cool. If we added more fields to the `Artist` struct, we'd need to update our calls to the initializer.
//: 
//: Structs can have functions on them, too. Consider the following `Artwork` struct.
struct FuncArtwork {
  let name: String
  let artist: Artist
  
  func getArtistName() -> String {
    return artist.name
  }
}
//: It has a function that returns the artwork's artist's name. It seems a bit silly to have that as a function, though, since it's always a computation. But we don't want to add another property like `artistName` to `Artwork`, since that's redundant. Instead, Swift let's us define what's called a _computed property_.
struct VarArtwork {
  let name: String
  let artist: Artist
  
  var artistName: String {
    get {
      return artist.name
    }
  }
}
//: Not bad, but we can do better. Computed properties can have getters and setters, specified with `get` and `set`. Sometimes you want a computed setter, like a temperature struct that stores the temperature in Celcius, but allows users to access the computed Fahrenheit value. You could _set_ the Fahrenheit property and have its setter update the underlying Celcius value.
struct Temperature {
  var celcius: Float
  
  var fahrenheit: Float {
    get {
      return celcius * 9.0/5.0 + 32
    }
    set (value) {
      celcius = (value - 32) * 5.0/9.0
    }
  }
}
//: But back to our `Artist`! Since read-only computed properties are so common, Swift has shorthad syntax. If a computed property is _only_ read-only, we can omit `get` altogether`.
struct Artwork {
  let name: String
  let artist: Artist
  
  var artistName: String {
      return artist.name
  }
}
//: Nice. Let's take a look at classes next.
//: 
//: A **class** in Swift is very similar to a struct, but also very different. The following **will not** work.
// Uncomment for an error
//class MyClass {
//  var property: String
//}
//: Unlike with structs, Swift doesn't infer initializers for classes. This leaves us with two options:
//: 
//: - Set all properties of the class to some initial value (pointless for constant properties like this one).
//: - Create an initializer that sets the properties before calling the superclass' initializer, if applicable.
//: 
//: Swift's compiler enforces these rules for safety. Our class would need to look like this:
class MyClassDefault {
  var property = ""
}
//: Or this:
class MyClassInit {
  var property: String
  
  init(property: String) {
    self.property = property
  }
}
//: That's a lot of boilerplate for not a lot of anything.
//: 
//: Classes are kind of a holdover from Objective-C, which didn't have Swift's concept of structs. Let's take a look at the different semantics around the difference between them.
//: 
//: First we'll need a test struct.
struct MyStruct {
  var property = ""
}
//: Simple enough – it has a variable property. Now try typing the following.
let a = MyClassDefault()
let b = MyStruct()

a.property = "Hi"
// Uncomment for an error
// b.property = "Hi"
//: You'll get a compiler error on the last line :boom: Why do you think that is?
//: 
//: Well, structs in Swift are _value types_, meaning that a change to the property of `b` is a change to `b` itself. Since we defined `b` as a `let` constant, we can't do that. `a` doesn't care because Swift classes are _reference types_. Changing the property of a class doesn't change the class itself.
//: 
//: So let's change `b` to be a `var`. We can access these properties and they should both be `"Hi"`.
//: 
//: Now let's get weirder. Let's create two new variables assigned to `a` and `b`.
let a2 = a
var b2 = b
a2.property = "Hello"
b2.property = "Hello"
//: What do you think happened to `a` and `b`? Let's check it out.
//: 
//: ![Surprising?](img/whoa.png)
//: 
//: `a`, which is a class, had its property changed when we changed `a2`'s property. But `b` is the same. Why?
//: 
//: Well, `a2` is a _reference_ to the same object as `a`. But `b2` is actually its own _value_, so changing it doesn't affect the original `b` at all. Swift manages this through _copy-on-write_ semantics that provides this sort of value-based immutability with the efficiency of reference typed-classes.
//: 
//: In Swift, we prefer structs to classes. However, Swift often has to interoperate with Objective-C (the operating system, frameworks, and most open source code is all sadly still Objective-C). So we use classes, too.
//: 
//: Alright, enough with that. Let's check out something really neat: enums.
//: 
//: An **enum** is a type that has one of a certain number values, defined at compile time. You might be familiar with them from C or Java.
enum MyEnum {
  case FirstOption, SecondOption
  case ThirdOption
}
//: We can use enums with the following syntax.
let e = MyEnum.FirstOption

switch e {
case .FirstOption:
  print("first")
case .SecondOption:
  print("second")
case .ThirdOption:
  print("third")
}
//: Super cool! And of course, Swift makes sure that our `switch` statement is exhaustive.
//: 
//: In C, all enums are integers. That is not true in Swift – this one has _no_ underlying type. You can't cast `MyEnum` values into anything else. But we could add an underlying value if we want.
enum MyIntEnum: Int {
  case FirstOption = 0
  case SecondOption // inferred to be 1, and so on
  case ThirdOption
}
//: So now we have a few neat things we can do.
print(MyIntEnum.FirstOption.rawValue)
//: This will print `0`, because that's `FirstOption`'s underlying value. We can also create `MyIntEnum` from raw integers, too.
let value = MyIntEnum(rawValue: 0)
//: However, because the initializer for `MyIntEnum` may fail if we pass in a value other than 0, 1, or 2, the type of `value` here is an _optional_. Specifically, `MyIntEnum?`. We learnt last time that we can unwrap optionals safely:
if let value = MyIntEnum(rawValue: 0) {
  // value is now a (non-optional) MyIntEnum
}
//: Neat. Swift also does something neat with enums that have underlying `String` values.
enum MyStringEnum: String {
  case FirstOption
}

print(MyStringEnum.FirstOption.rawValue) // Prints "FirstOption"
//: Unless otherwise specified, Swift infers that enums backed by strings should have raw values identical to their labels. Cool!
//: 
//: All of this is cool, I guess, but not Earth-shattering. Lots of other languages use enums this way. But Swift enums get _way_ cooler – they're probably my favourite feature.
//: 
//: Enum cases can have _associated values_. Let's see how they work with an example.
//: 
//: We need a `Result` enum that indicates whether an operation succeeded or failed. But we'd also like to know _why_ it failed. We _could_ approach this problem like this:
enum ResultBad {
  case Success
  case FailureDivisionByZero
  case Failure404StatusCode
  case FailureOutOfBounds
  // ... and so on
}
//: This sucks! And we need to know _all_ the possible ways something could fail at compile-time, which is often impossible.
//: 
//: What we'd really like is to indicate that a failure occured, with an explanation of _why_ it failed. We can do this with associated values!
enum Result {
  case Success
  case Failure(reason: String)
}
//: Let's imagine the following function.
func performAction(input: Int) -> Result {
  if input == 0 {
    return .Failure(reason: "Invalid input")
  } else {
    return .Success
  }
}
//: It takes an input and if it's zero, it returns `.Failure` with a message about _why_ it failed. Otherwise it returns `.Success`. It's a pedagogical example – we don't need anything completex.
//: 
//: How would we call this? Well, this is where `switch` statements come in handy:
switch performAction(0) {
case .Success:
  print("Success!")
case .Failure(let reason):
  print("Failure: \(reason)")
}
//: The `switch` lets us access the value associated with the `.Failure` case, and bind that value to a local `reason` variable. Really cool!
//: 
//: This is a pretty pedagogical example, but you can get a glimpse of the awesomeness of associated objects. We built an [entire network library](https://: github.com/Moya/Moya) using them!
//: 
//: Phew! That's a lot of stuff. One last thing: tuples. **Tuples** are simple structures – they are multiple values wrapped into a single value, and are defined using parentheses. This is a simple tuple.
let tuple = ("This is a value", 1)
//: In this example, `tuple` is of type `(String, Int)`. We can access the members of tuples using dot notation.
tuple.0
tuple.1
//: Gross. Let's use a _named_ tuple instead.
let namedTuple = (stringValue: "This is a value", intValue: 1)
namedTuple.stringValue // "This is a value"
namedTuple.intValue // 1
//: Note that this tuple is a _different type_ from the first one. It's `(String, Int)` compared with `(stringValue: String, intValue: Int)`. Yes, the labels in the tuples make them _different types_.
//: 
//: ----------------
//: 
//: OK, so all of this has really been discussing **generics** – one of the biggest missing pieces in Objective-C.
//: 
//: Generics let you specify that you're going to operate on a type without specifying _what_ type that is. Arrays are generics, for example. They hold stuff – anything, actually. We can do something similar.
//: 
//: Let's look at an easy one.
func doSomething<T>(input: T) -> T {
  return input
}
//: This is a really silly function – all it does is return what you give it. But it's declaration is interesting. The angle brackets mean that it works on a generic, named `T`. We can name it whatever we want, though.
//: 
//: The parameter `input` is of type `T`, even though we don't know what that is right now. Also, the function has to return something else of type `T`. We can all this function with nearly anything:
doSomething("hi")
doSomething(1234)
doSomething([1,2,3,4])
//: (Calling `doSomething(nil)` won't work, though. Can you guess why?)
//: 
//: Let's do something cooler. Let's build a simple stack datastructure.
struct Stack<T> {
  private var contents = Array<T>()
  
  mutating func push(input: T) {
    contents.append(input)
  }
  
  mutating func pop() -> T? {
    return isEmpty() ? nil : contents.removeLast()
  }
  
  func isEmpty() -> Bool {
    return contents.count == 0
  }
}
//: Neat, so now we have a stack. It holds an internal array called `contents`, and that array holds `T` (whatever that is). We can push, pop, and ask if the stack is empty.
//: 
//: The `push` and `pop` functions are interesting because they're marked as `mutating`. This ties in with Swift's constant structure. If they weren't mutating, the compiler would not let them change `contents`. Likewise, if a `Stack` is declarared using `let`, it cannot be mutated.
let stack = Stack<Int>()
// Uncomment for an error
// stack.push(1)
//: Instead, we need to use `var`.
var vstack = Stack<Int>()
vstack.push(1)
vstack.pop() // returns 1
//: You've seen we can do cool things with functions and stucts, but things get wilder with enums!
enum AssociatedResult<T> {
  case Success(result: T)
  case Failure(reason: String)
}
//: _Awesome_.
//: 
//: ----------------
//: 
//: Well, that's it for this week – what a huge lesson!
//: 
//: ![I really am.](img/proud.gif)
//: 
//: If you're keen to learn more, try applying generics to other things. Can classes be generic? What about tuples? What about inheritance – do you think one struct could extend another? What about structs with generics? What about functions returning structs using enums with associated generic values? Go wild!

//: # Lesson Three
//: 
//: Welcome back! [In the previous lesson](https://: github.com/orta/Swift-at-Artsy/tree/master/Informed/Lesson%20Two), we took a look through _a lot_ of stuff. We covered structs and classes, including the differences between the two. We learnt that structs are value types and classes are reference types, and how this affects Swift constant references declared with `let`. We also took a look at Swift enums, associated values on enums, and tuples. Finally, we looked at generics and got an idea of how they let us write abstract data structures.
//: 
//: This time, we're going to take a look at some of the cool higher order stuff Swift lets us do. We're going to look at closures and treating code as data, then look at lazily-loading properties for efficiency and style, and wrap up with protocols. We'll even briefly touch on generics.
//: 
//: ## Closures
//: 
//: A "closure" is a difficult term to define precisely because to different people, the term connotes different ideas and different amounts of precision. For _this_ lesson, we're going to define closures as code that is can be referred to and invoked, but that _isn't_ a function.
//: 
//: Closures have a place in most modern programming languages, even if they're called by a different name. For example, Javascript has anonymous functions.
//:
//: `var a = function() {`
//:
//: `    console.log("hi!");`
//:
//: `}`
//:
//: `a();`
//: 
//: Ruby has blocks and closures, with slightly different semantics, and Python has anonymous functions. Until OS X 10.6 and iOS 4, Objective-C developers didn't have _any_ concept of closures beyond C function pointers. This made things difficult.
//: 
//: Not so with Swift. Closures have been an integral part of the Swift language since day one, and have seen them advance since then.
//: 
//: A closure is very easy to use in Swift. The simplest example is this:
let c = { print("hi!") }
//: `c` is a constant that refers to a closure. The _type_ of `c` is `() -> ()`. This means it takes no arguments and has no return value. We can invoke `c` the way you'd normally invoke a function:
c()
let p = { (thing: String) -> () in
  print(thing)
}
p("hi!")
//: With `c`, we omitted the explicit parameter/return type specification. They're assumed to be empty if not specified.
//: 
//: And of course, we can return a value from a closure.
let double = { (thing: String) -> String in
  return "\(thing) \(thing)"
}
double("hi!")
//: Neat!
//: 
//: (Notice that the syntax for the parameters and return types of a closure look eerily similar to tuples with labels. Spooky.)
//: 
//: But that can be defined as a function just as easily as a closure. What benefit do closures have?
//: 
//: Well, the thing is that closures and functions are pretty much _the same thing_. We can actually [define a function within another function](https://: github.com/artsy/eidolon/blob/f22a7a0d5b338e8d934f0d4fdca2de51d07e367f/Kiosk/Sale%20Artwork%20Details/SaleArtworkDetailsViewController.swift#L76-L98) instead of a closure. However, the benefit of closures is that you can declare them _inline_. We'll see more of that momentarily.
//: 
//: Often times, closures are used to execute code more than once. Take the following example.
let range = 0..<10
range.forEach({ (number: Int) -> () in
  print(number)
})
//: (Note: I had to define `range` in a constant because `0..<10.forEach` introduces problems with operator precedence.)
//: 
//: The `forEach` function is defined on the `Range` type (sort of, we'll talk about that later). `forEach` takes a closure as a parameter and invokes it – once for every element in the range. It passes the element into the closure as a parameter, which we define as `number`.
//: 
//: Swift knows that we call functions like `forEach` _a lot_, and it tries to make this easier for us by letting us omit the parentheses around the closure definition.
range.forEach { (number: Int) -> () in
  print(number)
}
//: _Way_ cool. But we can do even better.
//: 
//: Since the parameter type for `forEach` is known to the compiler, it's able to infer the number and type of the arguments passed into the closure. This lets us refer to them by index instead of name. The following is semantically identical.
range.forEach { print($0) }
//: Neat! Another great function that takes a closure is `map`. This closure is passed in each element, just like `forEach`, but it has a _generic return value_. The return values for each invocation are used to make a new array that `map` returns.
range.map { return "\($0)" }
//: This returns an array of `String`s, zero through to nine. This convention is so common that for single-expression closures, Swift will infer the `return` statement.
range.map { "\($0)" }
//: A great use of closures is in the `reduce` function. This is a function that reduces a series of things into just one thing. For example, it can take a range of numbers and turn it into just one number. Or just one string or whatever – the series of things and what they're reduced to don't need to be the same type.
//: 
//: If we wanted to sum the numbers from 0 to 10, we could use `reduce`.
let sum = (0...10).reduce(0, combine: { $0 + $1} )
//: And remember, `sum`'s type is inferred by the compiler. How cool is that!
//: 
//: What's even more cool is that the type of the closure we used is `(Int, Int) -> Int`. Since closures and functions are interchangeable, I could pass in a function that adds two numbers.
func add(lhs: Int, rhs: Int) -> Int { return lhs + rhs }
(0...10).reduce(0, combine: add)
//: This seems like _way_ too much work. Luckily, Swift has a built-in `add` function called `+`.
(0...10).reduce(0, combine: +)
//: Reduce is good for more than just summing, though. The following will return the largest value in the array:
[5,1,88, 3, -100, 44].reduce(Int.min, combine: max)
//: We could also use closures to sort things:
[5,1,88, 3, -100, 44].sort(<)
//: Closures are a powerful tool that let programmers refer to executed code as data – parameters to be passed in to other functions and other closures. As we'll see over the next few lessons, they are used extensively throughout Swift.
//: 
//: Now that we've taken a look at closures, let's take a break and discuss efficiency.
//: 
//: ## Lazy Loading
//: 
//: A _lazy_ variable is one that doesn't have its value set until it is first accessed. That means if it is set to a type that get initialized, that initialization will be delayed until the lazy variable is first read from.
//: 
//: This is valuable when you have a resource-intensive thing that shouldn't be created before it's used. For example, an image that takes up a lot of RAM (which is scarce on iPhones), or a complex computation that takes several seconds to execute.
//: 
//: (Note: all global variables are lazy to avoid consuming too many at app startup, probably.)
//: 
//: Of course, the downside of lazy properties is that they delay execution of code that could be done before its needed. It's a balance that's up to each coder in each circumstance.
//: 
//: You _could_ do lazy properties yourself, like this:
//struct Whatever {
//  private var internalThing: Thing?
//  
//  var thing: Thing {
//    if let internalThing = internalThing {
//      return internalThing
//    } else {
//      internalThing = Thing()
//      return internalThing!
//    }
//  }
//}
//: ... except that setting `internalThing` is not allowed because that mutates the instance. Anyway, this _same_ code could be accomplished with _one_ keyword:
//struct Whatever {
//  lazy var thing = Thing()
//}
//: Lazy properties can be helpful in unit testing with dependency injection, but not in the limited way we've seen them so far. We now need to look at lazy computed properties.
//: 
//: ## Lazy Closure Properties
//: 
//: Before we dive into lazy computed properties, which are _really_ cool, I'd like to go back to first principles on why they're useful. We've already seen how lazy variables are good at delaying expensive resource allocations, but I believe that their power goes beyond just efficiency. They present a way to write codes that is simply _more awesome_.
//: 
//: Typically, members of a struct or class with a default value have that value set when the instance is initialized.
struct PersonDefault {
  var name = ""
}
//: When we call `Person()`, we create a new instance, and the name property is set to an empty string. However, not all properties need to exhibit this behaviour. For example, let's consider a new `Person` struct.
struct PersonNonDef {
  let firstName: String
  let lastName: String
}
//: OK, so `firstName` and `secondName` never change. We _could_, if we wanted to, create a computed property for `fullName`.
struct OKPerson {
  let firstName: String
  let lastName: String
  
  var fullName: String {
    return "\(firstName) \(lastName)"
  }
}
//: This is _OK_ – the code will run and work as you expect.
var orta = OKPerson(firstName: "Orta", lastName: "Therox")
orta.fullName // returns "Orta Therox"
//: But every time you call `fullName`, you're performing the same computation based on the same two constant properties. The `fullName` computed property will _always_ return the exact same values. It would be better if we could compute the value _once_, and then remember it.
//: 
//: This is possible by combining lazy variables and closures. A lazy property can be set to a self-evaluating closure. When the property is first accessed, the closure is executed and its return value is set to the property. The closure is guaranteed to only ever be executed once, if ever, in a lifetime of an instance. Let's see this in action.
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
//: There's a lot to unwrap here. First, the `fullName` property is no longer computed – it's value is stored – so we need a custom initializer (the inferred initializer is `init(firstName: String, lastName: String, fullName: String)`, which is silly).
//: 
//: The next thing is the `fullName` property. It's marked as `lazy` to indicate that the right-hand side of the `=` sign shouldn't be evaluated until the property is first accessed. When it is, the right-hand side is a closure that is immediately evaluated (notice the `()` on the end). Its return value is set to the instance, and the computation is never performed again.
//: 
//: This _self-evaluating, lazily-evaluated closure properties_ approach has a lot of advantages. First, unlike normal lazy properties, the closure has access to `self`, so it can use the current state of the instance when setting up the property value.
//: 
//: More than that is that it allows us to easily inject dependencies when unit testing. Simply inject a tests _own_ stubbed dependency before the subject's is accessed. The closure will never be executed.
//: 
//: ## Protocols & Generic Constraints
//: 
//: Protocols are a way to loosely couple code together by indicating that a type conforms to a certain set of functions. Other languages sometimes call these interfaces.
//: 
//: Conforming to a protocol is easy.
//struct MyInt: BooleanType {
//  let value: Int
//}
//: This struct conforms to the `BooleanType` protocol. However, this doesn't compile; we haven't implemented the necessary functions.
struct MyInt: BooleanType {
  let value: Int
  
  var boolValue: Bool {
    return value != 0
  }
}
//: Now we're fine.
//: 
//: But why conform at all? Well, now that we conform to BooleanType, we can use boolean operators and logic on instances of our struct.
let a = MyInt(value: 1)
let b = MyInt(value: 0)

a && b
a || b
!b
//: Mostly, you'll use protocols to hook into existing Swift features, but they're also useful for loosely coupling types. That's beyond the scope of this lesson, though it's an important concept for writing iOS and OS X apps.
//: 
//: We can also combine protocols with generics, which is super-fun. We're going to touch on this _briefly_, and return to it next week.
//: 
//: Here, we see a struct that conforms to `BooleanType` and operate on a generic type `T`, which _also_ must conform to `BooleanType`.
struct MyBool<T: BooleanType>: BooleanType {
  let value: T
  
  var boolValue: Bool {
    return value.boolValue
  }
}
//: `MyBool` will pass through calls to `boolValue` to its underlying value, which we constrain. `T` _must_ conform to `BooleanType`, or you'll get a compiler error.
// Uncomment for an error
//MyBool(value: "what is this???")
//: We can now use and reason about `MyBool` instances with the same boolean logic as `MyInt`, since they both conform to `BooleanType`.
let x = MyBool(value: true)
!x

let y = MyBool(value: MyInt(value: 1))
!y
//: Protocols and generics get _way_ more powerful when you combine other Swift features like operator overloading and protocol extensions, which we'll cover soon.
//: 
//: ----------------
//: 
//: We've seen a lot in this lesson, mostly abstract concepts. Try playing around with protocols – how could you create your own? Why would that be useful? What other uses could you see for lazy computed values using closures? Could you combine them with protocols somehow, like a lazy property whose type is defined as a generic conforming to a protocol?
//: 
//: Until next time!
//: 
//: ![Until next time!](http://: media0.giphy.com/media/W0crByKlXhLlC/giphy.gif)

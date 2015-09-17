//: # Lesson Four
//: 
//: Last time, we covered closures, lazy loading, lazy loading _with_ closures, and protocols. We _barely_ touched on protocols, which I said were one of my favourite Swift features. That's because some of the coolest uses of protocols also use other Swift features we haven't learnt yet.
//: 
//: Until today.
//: 
//: We're going to cover only two topics, but they're big ones. First we'll look at operator overloading. Then we'll look at extensions, then protocol extensions, two powerful tools that expand on what we learnt last time. Let's dive in!
//: 
//: ## Operator Overloading
//: 
//: Like it or not, operator overloading exists in Swift. In fact, operators are defined as simple functions, which makes `[2,1,3].sort(<)` possible. `<` is an operator, but it's also a function, which means it can be treated as a closure. Neat!
//: 
//: Operators are _really_ easy to define. If you're defining a _new_ operator, you should define its type and precedence. This example comes from [Nimble](https://: github.com/Quick/Nimble/blob/8baefcc94bc2b58b7be3cd9ebfc3984ea5c8b87e/Nimble/Matchers/BeCloseTo.swift#L95), a tool we actually use for writing unit tests.
infix operator ≈ {
associativity none
precedence 130
}

//public func ≈(lhs: Expectation<[Double]>, rhs: [Double]) {
//  lhs.to(beCloseTo(rhs))
//}
//: The operator is infix, meaning it goes _between_ its two parameters (just like `+`). These parameters are technically called _operands_. You can use the operator definition to define precedence and associativity rules so that the operator "feels" right.
//: 
//: The operator can be used like:
// expect(thing) ≈ 4.5
//: Neat!
//: 
//: We can expand existing operator definitions to use new types, as well. Let's take a look at a short example.
//: 
//: Swift knows how to add two arrays together. `["a"] + ["b"] = ["a", "b"]`, but it can't do something like `"a" + ["b"] = ["a", "b"]`, which we'd like to change. This is actually fairly straightforward.
func +(lhs: String, rhs: [String]) -> [String] {
  var value = rhs
  value.insert(lhs, atIndex: 0)
  return value
}
//: This works, but only for strings. It would be super-cool if we could define the operator for _any_ type. As it so happens, we can use generics for this.
func +<T>(lhs: T, rhs: [T]) -> [T] {
  var value = rhs
  value.insert(lhs, atIndex: 0)
  return value
}
//: Boom. Now you can add elements to arrays no matter what their type.
//: 
//: There are lots of great uses of operator overloading, and then there's [this one](https://: github.com/ashfurrow/Nimble-Snapshots/blob/890a9a9349adc720c3acfeb6a3de041cb787613b/PrettySyntax.swift#L27) that we actually use in our app:
//public func 📷(snapshottable: Snapshotable) {
//  expect(snapshottable).to(recordSnapshot())
//}
//: It's used to record snapshots of view and things. Still pretty cool, though.
//: 
//: Another useful example is to abstract something away inside an existing operator. For example, we use an automatically generated enum of Strings to identify something called a _segue_. A lot of the time, we need to see if a segue we are given matches a particular segue identifier's `rawValue`. We do [this](https://: github.com/artsy/eidolon/blob/f22a7a0d5b338e8d934f0d4fdca2de51d07e367f/Kiosk/App/UIStoryboardSegueExtensions.swift#L6-L8) once:
//func ==(lhs: UIStoryboardSegue, rhs: SegueIdentifier) -> Bool {
//  return lhs.identifier == rhs.rawValue
//}
//: And from now on, instead of this...
//if segue.identifier == SegueIdentifier.ShowLoadingView.rawValue {
//  let nextViewController = segue.destinationViewController as! LoadingViewController
//  nextViewController.placingBid = placingBid
//}
//: ...we can do [this](https://: github.com/artsy/eidolon/blob/720b6eae23e68d6de7ad6ed7c05d3480c226716f/Kiosk/Bid%20Fulfillment/RegisterViewController.swift#L71-L74)...
//if segue == .ShowLoadingView {
//  let nextViewController = segue.destinationViewController as! LoadingViewController
//  nextViewController.placingBid = placingBid
//}
//: Which is much nicer.
//: 
//: Nimble also uses the generic constraints we saw last time in [its operators](https://: github.com/Quick/Nimble/blob/c3b755106ceb154c2512e4cee8ba5df9d3ad39af/Nimble/Matchers/Equal.swift#L102-L104):
//public func ==<T: Equatable>(lhs: Expectation<T>, rhs: T?) {
//  lhs.to(equal(rhs))
//}
//: This means that the `==` operator applies only to things that conform to the `Equatable` protocol. Super cool!
//: 
//: ## Extensions
//: 
//: Extensions are a way to extend an existing type. This can be a type that you define, or a built-in type. These are similar to Ruby's mixins.
//: 
//: For example, we can extend the `Int` type to add a `times` function.
extension Int {
  func times(closure: () -> ()) {
    (0..<self).forEach { _ in closure() }
  }
}
//: Now we can do cool Ruby-like stuff:
4.times { () -> () in
  print("hi!")
}
//: I've explored some other neat things, surrounding date types, like `NSTimeInterval` and `NSDate`, so you could do `4.hours.fromNow`, etc.
//: 
//: Extensions are used, ahem, _extensively_ in our apps. They offer a way to abstract out commonly used code without putting it in a superclass.
//: 
//: ## Protocol Extensions
//: 
//: Protocol _extensions_ are a way to add functions to a protocol, just like we can add extensions to any other type. The cool thing is that they can use methods already defined on the protocol! Let's take a look at an example.
//: 
//: Say I have a protocol that is defined as "holding something" – an array or string, for example.
protocol Occupiable {
  var isEmpty: Bool { get }
  var isNotEmpty: Bool { get }
}
//: We define two read-only variables, `isEmpty` and `isNotEmpty`. Being empty and not empty are mutually exclusive, since one is the opposite of the other. It makes sense, then, to provide a default implementation of one of these two variables.
extension Occupiable {
  var isNotEmpty: Bool {
    return !isEmpty
  }
}
//: Cool, now whenever you want to add conformance to the `Occupiable` protocol, you only need to define _one_ variable instead of two.
//: 
//: Recall our `Stack` from [Lesson Two](https://: github.com/orta/Swift-at-Artsy/tree/master/Informed/Lesson%20Two). We can extend it to include an `isEmpty` variable.
// Basic definition
struct Stack<T> {
  private var contents = Array<T>()
  
  mutating func push(input: T) {
    contents.append(input)
  }
  
  mutating func pop() -> T {
    return contents.removeLast()
  }
}

// Extension
extension Stack: Occupiable {
  var isEmpty: Bool {
    return contents.isEmpty
  }
}

var stack = Stack<String>()
stack.push("hi!")
stack.isEmpty
stack.isNotEmpty
//: Now we can use `isNotEmpty` on our stack because it can rely on the existing protocol extension. Super awesome!
//: 
//: Another neat thing is that you can add conformance to types that may already have `isEmpty` defined. `String` has an `isEmpty` computed variable, so we can add `Occupiable` conformance with one line of code:
extension String: Occupiable { }
//: Now all strings have `isNotEmpty` defined on them, too. In fact, we can do this for more than just strings:
extension Array: Occupiable { }
extension Dictionary: Occupiable { }
extension Set: Occupiable { }
//: The `isEmpty` variable used on arrays, dictionaries, and sets is defined in the `CollectionType` protocol. It would be awesome if we could indicate to Swift that the `CollectionType` protocol itself conforms to `Occupiable`. We would do so like this:
extension CollectionType where Self: Occupiable { }
//: This will compile, but due to a limitation in the current Swift compiler, it doesn't actually work. Oh well 😄
//: 
//: OK, so protocol extensions are neat I guess, but they gets _even_ cooler. We can extend an existing type that uses generics, and then constrain the extension to cases where the generic type conforms to a protocol.
//: 
//: ಠ_ಠ
//: 
//: That's a lot to unwrap, so let's go over that again.
//: 
//: Some types work on generics, like our `Stack`. We can define an extension on `Stack` that _only_ works certain stacks. These stacks need to be stacks of something that conforms to another protocol.
extension Stack where T: Occupiable {
  
}
//: Now inside this extension, we can operate on the `contents` array of `T`, under the compile-time checked condition that `T` conforms to `Occupiable`.
//: 
//: Why on _Earth_ would this be useful? Well, prepare for liftoff 🚀
//: 
//: I had a problem in Eidolon where I had a lot of optional strings. I would do things like this:
let optionalString: String? = "hiya"
if (optionalString ?? "").isEmpty {
  // optionalString is empty or nil
}
//: I thought it would be super cool to extend the `Optional` type to let me use `isEmpty` on optional strings. [This implementation](https://: github.com/artsy/eidolon/blob/739dee0b2d1fdb4e3a6a5a409cc8792b5addb9a3/Kiosk/App/SwiftExtensions.swift#L43-L56) is currently in the production app.
//: 
//: The first thing we need to do is define an extension on `Optional` that applies _only_ to optionals that conform to `Occupiable`.
extension Optional where Wrapped: Occupiable {
}
//: The `Wrapped` part comes from the definition of the `Optional` type, which you can see by command-clicking on the `Optional` type.
//public enum Optional<Wrapped>
//: So now that we have our extension, let's add something to it. I don't like the idea of `isEmpty` on optionals, since it conflates an empty string with a string that is `nil`. Instead, we'll be explicit.
extension Optional where Wrapped: Occupiable {
  var isNilOrEmpty: Bool {
    switch self {
    case .None:
      return true
    case .Some(let value):
      return value.isEmpty
    }
  }
}
//: Remember, the `value` – whatever it is – conforms to `Occupiable`. We use the `case` statement to unwrap the optional type, then call through to `isEmpty`. Nice and easy!
//: 
//: I think it's really cool that Swift lets us combine disparate APIs together like this. The original `Optional` type has no idea about our extension or the `Occupiable` protocol at all, but here it is extended to do some really cool stuff.
//: 
//: ----------------
//: 
//: We've covered a lot of cool stuff today, which wraps up most of our exploration of Swift's features. The next lesson is our last, where we'll cover error handling and get a taste of functional programming. It's gonna be _awesome_.
//: 
//: ![Awww yeah.](http://: i.imgur.com/mONiWzj.gif)
//: 
//: If you're looking for something to do in the mean time, explore the Swift standard library and look for other ways to extend existing types and protocols.

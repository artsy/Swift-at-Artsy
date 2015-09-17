//: # Lesson Five
//: 
//: Welcome to the final lesson! We've covered quite a bit of Swift so far, from generics, optionals, and protocols, to the operator overloading and extensions we saw in the previous lesson. Today we're going to be wrapping up with a discussion of **error handling** and then a brief discussion about **functional programming**. Let's dive in!
//: 
//: ## Error Handling
//: 
//: Due to historical reasons involving Objective-C, iOS developers have typically not used exceptions in day-to-day programming. Apple's APIs tend to be focused around checking for error conditions before an operation is performed, and only throwing exceptions in truly exceptional circumstances. The resulting gymnastics are a feat of obscure C-style code that is better left in the past.
//: 
//: Instead, Swift introduces exception-like syntax (including interoperability with Objective-C's old APIs). Swift's error-handling is _like_ exceptions in that you see similar keywords (`try` and `catch` and `throw`), but is incredibly efficient. `throw`ing an error in Swift does not unwind the call stack, and is roughly as efficient as a simple `return` statement.
//: 
//: However, just because iOS/OS X developers _can_ now `throw` things all over the place doesn't mean we _should_.
//: 
//: ![The Goldblum](http://media-cache-ak0.pinimg.com/736x/e8/f6/85/e8f68586c05e9c608bf08efa1daeb752.jpg)
//: 
//: A function that throws errors must explicitly be marked as `throws`, otherwise you'll get a compiler error. This serves three purposes:
//: 
//: - Keep mental overhead to a minimum.
//: - Avoid overuse of `throw`.
//: - Compile-time safety.
//: 
//: Forcing functions to be marked as `throws` lets the compiler verify that the invoking code handle the error somehow. Super-cool!
//: 
//: Another difference between exceptions and Swift's... whatever it's called is that you can throw any type, as long as it conforms to the `ErrorType` protocol. What's in that protocol? Nothing!
// public protocol ErrorType {}
//: (╯°□°）╯︵ ┻━┻
//: 
//: Basically anything can be an error, but Swift enums are typically the best choice. They're defined at compile-time, which will come in handy later, and they can use associated values to provide more context for the error.
//: 
//: So let's see some code. We're going to define a store's inventory system. An inventory has a bunch of things for sale, defined as a dictionary between their name and an `Item`. If you want to buy something, you call a function with the name of what you want and a credit card. If everything goes well, you get back an item. But of course, sometimes things go wrong.
//: 
//: Let's start with the basics.
class CreditCard {
  var remainingCredit: Int = 0
}

struct Inventory {
  struct Item {
    var price: Int
    var stock: Int
  }
  
  var items: [String: Item]
}
//: OK, we've got a `CreditCard` class, which is useful for its reference-type semantics (we can modify it within our function), `Inventory` and `Item` structs, and a property on `Inventory` that defines our dictionary of items we have in stock.
//: 
//: Next we'll need some error conditions to throw. Let's add this enum to our `Inventory` class.
extension Inventory {
  enum Error: ErrorType {
    case ItemNotFound
    case OutOfStock
    case InsufficientFunds(requiredBalance: Int)
  }
}
//: These represent the different things that can go wrong within our buying function.
//: 
//: With our errors defined, we're ready to make our function. This will go inside the `Inventory` struct.
extension Inventory {
  mutating func buyItemNamed(name: String, withCreditCard creditCard: CreditCard) throws -> Item {
    if var item = items[name] {
      if item.stock > 0 {
        if creditCard.remainingCredit >= item.price {
          creditCard.remainingCredit -= item.price
          item.stock--
          items[name] = item
          return item
        } else {
          throw Error.InsufficientFunds(requiredBalance: item.price)
        }
      } else {
        throw Error.OutOfStock
      }
    } else {
      throw Error.ItemNotFound
    }
  }
}
//: There's a lot to unpack here. First, notice the `throws` keyword in the definition. This marks the function as able to throw errors. Since the function changes the `items` dictionary, it has to me marked as `mutating`. The function logic flows as follows:
//: 
//: 1. Lookup the item.
//: 2. If the item exists, check its stock.
//: 3. If we have the item in stock, check the credit available.
//: 4. If the customer can pay for the item, adjust our `items`, their credit card, and return the purchased item.
//: 
//: If anything goes wrong in this process, throw the appropriate error.
//: 
//: Let's see how we'd call this function.
var inventory = Inventory(items: [
  "shirt": Inventory.Item(price: 20, stock: 4),
  "pants": Inventory.Item(price: 40, stock: 8),
  "shoes": Inventory.Item(price: 50, stock: 2)
  ])

let creditCard = CreditCard()
creditCard.remainingCredit = 100
// Uncomment for an error
// inventory.buyItemNamed("shirt", withCreditCard: creditCard)
//: Right now, this fails. Why? Well, if a method can throw, you have to acknowledge this whenever you invoke it. We need to put the `try` keyword in front of our invocation.
try inventory.buyItemNamed("shirt", withCreditCard: creditCard)
//: 💥 Awesome. But this only works because our playground is in a global scope, and can handle errors. We should put our invocation in a scope that forces _us_ to deal with errors.
func buyThing() {
  do {
    let item = try inventory.buyItemNamed("shirt", withCreditCard: creditCard)
    print("buying \(item)")
  } catch Inventory.Error.ItemNotFound {
    print("Item not found")
  } catch Inventory.Error.OutOfStock {
    print("Item out of stock")
  } catch Inventory.Error.InsufficientFunds(let requiredBalance) {
    print("You don't have enough credit: \(requiredBalance).")
  } catch {
    print("Something happened?")
  }
}
//: We've put this in a function so that the compiler will force us to be exhaustive. Unfortunately, that means we need a default, `catch`-all statement, which is too bad. Oh well.
//: 
//: Ok, so another way we could do this is to mark the `buyThing` function as `throws`, too. We'd still need to specify `try`, but we wouldn't have to handle the errors.
//: 
//: We can also be fancy about `catch` statements using `where` clauses.
do {
  let item = try inventory.buyItemNamed("shirt", withCreditCard: creditCard)
  print("buying \(item)")
} catch Inventory.Error.ItemNotFound {
  print("Item not found")
} catch Inventory.Error.OutOfStock {
  print("Item out of stock")
} catch Inventory.Error.InsufficientFunds(let requiredBalance) where requiredBalance > 30 {
  print("You don't have enough credit for this expensive thing: \(requiredBalance).")
} catch Inventory.Error.InsufficientFunds(let requiredBalance){
  print("You don't have enough credit: \(requiredBalance).")
} catch {
  print("Something happened?")
}
//: Let's say we don't care about the errors. What if we just want the item, if it exists? Well, Swift has a `try?` statement. If an error is thrown, it returns `nil`. Easy!
if let purchasedItem = try? inventory.buyItemNamed("pants", withCreditCard: creditCard) {
  print("Bought some pants: \(purchasedItem)")
}
//: Just like we can force-unwrap an optional, we can force-unwrap the optional returned from `try?`. The following two lines are equivalent.
// Uncomment for an error
//(try? inventory.buyItemNamed("shoes", withCreditCard: creditCard))!
//try! inventory.buyItemNamed("shoes", withCreditCard: creditCard)
//: The thing is, if an error _is_ thrown, then you app crashes. `try!` is just as dangerous as force unwrapping an optional and should be avoided whenever possible.
//: 
//: Let's return to our throwing function. It's pretty ugly, eh? All that indenting! Let's rearrange things with `guard` statements.
//: 
//: Basically, a guard tries to perform something and if it fails, then it can execute some code to exit your scope.
//guard let thing = optionalThing else {
//  throw ThingIsNilError
//}

// thing is now accessible as a non-optional 🎉
//: `guard` is super-cool since it lets us avoid nest if-lets. More importantly, the `throw`ing code is _a lot_ closer to the code that is responsible for throwing it (instead of ten lines later in an `else` branch).
//: 
//: Our new function would look like this.
extension Inventory {
  mutating func buyItemNamedGuard(name: String, withCreditCard creditCard: CreditCard) throws -> Item {
    guard var item = items[name] else {
      throw Inventory.Error.ItemNotFound
    }
    guard item.stock > 0 else {
      throw Inventory.Error.OutOfStock
    }
    
    guard creditCard.remainingCredit >= item.price else {
      throw Inventory.Error.InsufficientFunds(requiredBalance: item.price)
    }
    
    creditCard.remainingCredit -= item.price
    item.stock--
    items[name] = item
    return item
  }
}
//: Super-nice!
//: 
//: One more thing I'd like to mention is the `defer` keyword. This is useful for when we need something to happen when program execution exits a scope, no matter how it exits. `defer` can be used as a sort of `finally` to execute something that must be accomplished no matter what. Let's take a trivial examples.
//mutating func buyItemNamed(name: String, withCreditCard creditCard: CreditCard) throws -> Item {
//  defer {
//    // Always thank our customers.
//    print("Thanks for shopping at $STORE_NAME!")
//}
//: Nice. Now, whenever we leave our function's scope, we print this message to the console. This is useful for closing sockets and file handles, as well as other clean-up code.
//: 
//: So our inventory example is done, but there's one more thing I want to mention. Remember how closures and functions are essentially the same thing? Well, if functions can `throw`, shouldn't closures be able to as well?
//: 
//: Sure! And it has all the same semantics.
let a = { () throws -> () in
  
}

try a()
//: What's _even cooler_ is that you can mark functions that take throwing closures as `rethrows`, which is really neat. `rethrows` basically means "I take a closure that can throw, and if it does, I throw too, but if it doesn't, then I don't either."
//: 
//: Confused? Don't worry, it's a bit tricky. Basically, you pass in a closure and if that closure doesn't actually throw anything, then invoking that function doesn't need to worry about catching anything. However, if the function _does_ throw, then the function must be called with `try` etc. Consider the following example.
func f(callback: () throws -> Void) rethrows {
  try callback()
}
//: If we call `f({})`, the empty closure doesn't throw, so we don't worry about anything.
func s() {
  // Closure doesn't throw, so I don't have to catch.
  f { () -> Void in
    print("hi!")
  }
}
//: But let's say we have a closure that can throw.
func t() {
  // Closure _does_ throw, so now I have a mess to deal with.
  do {
    try f { () -> Void in
      try inventory.buyItemNamed("tshirt", withCreditCard: creditCard)
    }
  } catch {
    print("Something went wrong!")
  }
}
//: Now the compiler forces us to `catch` stuff. Neat!
//: 
//: This technique is used throughout the Swift standard library. You've been using functions marked as `rethrows` and didn't even know it! `map` and `forEach` are both methods marked as `rethrows`.
[1, 2, 3].map { (t) -> String in
  "\(t)"
}

try ["shirt", "shoes", "pants"].map { name -> Inventory.Item in
  return try inventory.buyItemNamed(name, withCreditCard: creditCard)
}
//: So now that we're familiar with error-handling, let's talk about functional programming.
//: 
//: ## Functional Programming
//: 
//: Ah yes, functional programming, the perennially ill-defined term that scares the bejeezus out of beginners. How do I love thee? Let me `count()` the ways...
//: 
//: Ahem.
//: 
//: Swift is pretty friendly to functional programming, which is awesome!
//: 
//: I can't get into a lot, but basically functional programming is treating functions as first-class citizens in your language, which Swift does. You can assign a function to a variable, and it has a predictable type.
func add(lhs: Int, _ rhs: Int) -> Int {
  return lhs + rhs
}

add(2, 3) // Returns 5

let someVariable = add
//: In this case, `someVariable` has the type of `(Int, Int) -> Int`, just like a closure would.
//: 
//: Hey, ever notice how function invocation syntax looks a lot like a tuple? Think about it – it's basically `functionName` and then `(parameters)`, and the parameters look just like a tuple.
//: 
//: Well! It turns out you _can_ invoke functions assigned to variables with tuples!
let parameters = (2, 3)
someVariable(parameters) // Returns 5
//: Really cool! Note that you need to match any tuple labels, because labels are part of a tuple's type.
func subtract(lhs: Int, _ rhs: Int) -> Int {
  return lhs - rhs
}
let someOtherVariable = subtract
let newParameters = (3, fromNumber: 10)
//someOtherVariable(newParameters)
//: Currying is also really common. We do stuff like this in our apps all the time.
//: 
//: Say you're filtering by whether or not a string contains `@` (basically looking for email addresses). You'd like to write this code once and refer to it later, then use `filter` by passing in this function. Easy.
func containsAt(string: String) -> Bool {
  return string.characters.contains("@")
}

let input = ["ash@example.com", "orta at example.com", "jory@example.com"]

input.filter(containsAt)
//: But then you notice that you're filtering for strings containing a `$` as well. And `.`. And `%` and lots of strings! It'd be nice to abstract the searching away regardless of what you're searching for.
//: 
//: This is what currying is for. We want to call a function that returns another function.
func contains(suspect: Character) -> (String -> Bool) {
  return { string -> Bool in
    return string.characters.contains(suspect)
  }
}

input.filter(contains("@"))
//: The `contains` function returns a function of type `String -> Bool`, which is what our `filter` function wants – cool!
//: 
//: This sort of thing is so common that Swift actually as shorthand syntax.
//func contains(suspect: Character)(string: String) -> Bool {
//  return string.characters.contains(suspect)
//}
//: This `contains` function is semantically identical to the previous one, but without the extra indentation and complicated signature. Nice.
//: 
//: That's all the time we really have to talk about functional programming – it's an exciting topic, and I'd highly recommend you [go buy this book](https://www.objc.io/books/fpinswift/) if you'd like to learn more!
//: 
//: ----------------
//: 
//: That's everything, folks! I hope you've enjoyed this learning process. It's been fun and rewarding to write and instruct this course.
//: 
//: ![Bye bye!](http://media3.giphy.com/media/WvaQl1OsPvkZO/giphy.gif)
//: 
//: If you have questions, [open an issue](https://github.com/orta/Swift-at-Artsy/issues/new) and we'll get back to you.

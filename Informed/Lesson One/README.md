Welcome! This first lesson's goals are to introduce you to the tools used to write Swift. We're also going to go over some language features that are unique to Swift, and some that you may have seen before.

We're going to assume that you already have a copy of Xcode 7 installed. With that, let's get started!

Open Xcode and you'll get this Welcome dialogue. 

![Xcode Welcome Screen](img/welcome.png)

We'll be using _playgrounds_ to learn Swift. These are similar to a REPL if you've used one of those before. Click "Get started with a playground", give it a name, and make sure the platform is set to **OS X**. 

![Creating a new playground](img/newplayground.png)

Awesome. Xcode will create an open the playground for you. It'll look something like this. 

![Empty Playground](img/emptyplayground.png)

The large pane on the left is where we're going to write code. On the right is where the results of our code are displayed. You can see that there's already one line of code written for us, `var str = "Hello, playground"`, and the results pane says `"Hello, playground"`. Neat. 

Whatever you type will be run by Xcode and the results will be shown on the right. When Xcode is running code (whenever you change text), the top bar of the window will change to say "Running" and will show a little spinner. 

OK, let's try typing some things. 

```swift
var str = "Hello, playground"

1 + 2
1/2
1.0/2.0

str = "Artsy"

"Hello, Artsy"

"Hello, \(str)"
```

You can see the results in the results pane:

![Results](img/results.png)

These aren't necessarily surprising – integer division works like it does in most C-based languages, for example. Swift uses `\()` to escape code within strings, similar to Ruby's `#{}`. 

Swift defines variables using `var`. While there is no type specified, the variable `str` is a `String`. Swift is a **strongly-typed language**, even though most of the time you don't explicitly annotate types. The compiler _infers_ the type of variables. So the following two lines are equivalent.

```swift
var myString = "Hello, Artsy"
var myString: String = "Hello, Artsy"
```

In Swift, `:` specifies types. Let's try breaking things – what happens if we mismatch the types?

```swift
var myString: String = 1
```

Swift will complain and say that `'Int' is not convertible to 'String'`. This is Swift's compile-time static type checker. It prevents bugs from happening in apps at runtime by giving you errors at compile-time. Swift's primary goal is safety. 

Let's try breaking other things. Variables in Swift are defined using `var`, but Swift has constant support, too. In fact, constants declared with `let` are preferred to variables. 

```swift
let constant = "Constant"
constant = "new value"
```

Swift will error and say that it can't assign to a constant value. However, Swift is very clever about constants. It only lets you assign to them _once_, but you don't need to assign to them when you declare them. This is valid Swift:

```swift
let name: String

if someCondition {
    name = "Ash"
} else {
    name = "Orta"
}

print(name)
```

Super-cool! You can also see how Swift's `if` statements work. You _don't_ need parentheses around the condition, but you _do_ need braces around the statements. Swift doesn't have support for single-line if branches, so it's impossible to write `goto fail;` bugs. 

`for` loops follow a similar convention:

```swift
for var i = 0; i < 10; i++ {
    print("Hi: \(i)")
}
```

But if we look at the results pane, we see it only says "(10 times)" – that's because it's unable to show the output from lines of code that get executed more than once. 

![Results for lines run multiple times](img/tentimes.png)

To see these results, we'll open the debug area. Click the small, upward-facing triangle in the lower-left corner of the window.

![Debug area](img/multipleresults.png)

Swift also has some other really neat constructs, like _ranges_. The `for` loop from earlier could be rewritten as the following:

```swift
for i in 0..<10 {
    print("Hi: \(i)")
}
```

This does the same thing, but has a crucial difference: `i` is a constant, so it can't be diddled with by the loop. Super-safe!

OK, let's get to something more tricky. 

Let's pretend we're writing a Google Translate competitor. It only translates to French right now, but that's OK – we're focusing on our MVP while we raise VC funding. We want to write a function that takes a string as an argument and returns a string. The function would look something like this. 

```swift
func translate(english: String) -> String {
    return "something"
}
```

The syntax is fairly straightforward. It takes a string in, and returns a string. Neat. Let's fill it out a bit.

```swift
func translate(english: String) -> String {
    switch english.lowercaseString {
    case "hi":
        return "Bonjour"
    case "what time is it?":
        return "Quelle heur fait-il?"
    default:
        return ""
    }
}
```

Like I said, it's a work in progress. 

Our function uses the `switch` statement, but Swift enforces that all `switch` statements must be _exhaustive_. We need a `case` for _every_ possible value. Since that's not possible, we use the `default` case. Also notice that Swift doesn't require `break` statements – cases don't "fall through" like C or other languages. 

The problem with our `translate()` function is that if it _doesn't_ know how to translate something, it needs a way to tell whoever called it that it failed. This is a common problem in programming, and Swift's solution is one that tries to ensure the safest possible code.

Swift uses _optionals_ to indicate "missing" values. They're useful for when you don't know if something is there, or not. This might sound familiar to .Net developers, or someone  who has played with Haskell. 

Let's rewrite our method to use optionals. 

```swift
func translate(english: String) -> String? {
    switch english.lowercaseString {
    case "hi":
        return "Bonjour"
    case "what time is it?":
        return "Quelle heur fait-il?"
    default:
        return nil
    }
}
```

Notice that the function now returns `String?`, an _optional string_. Now our function is able to return `nil` whenever the translation fails. We can call the method and assign its return value to a `let` constant.

```swift
let translatedString = translate("Hi")
```

There's just _one_ small different. `translatedString` is not a `String`, it's a `String?`. How do I know? In Xcode, you can hold the option key ⎇ and click on a variable to see its type. 

![Optional string](img/optional.png)

So it's an optional – how do we turn it into a `String`? Swift actually has really nice syntax for this called `if let`. It looks like the following. 

```swift
if let translatedString = translate("Hi") {
    print("Translated as '\(translatedString)'")
} else {
    print("Translation failed, contact support.")
}
```

The first `if` branch is executed only if the return value of our function call is _not `nil`_. Swift will assign the non-`nil` return value to `translatedString`, which is a `String` (not a `String?`).

You can even double check this behaviour by ⎇-clicking on the variable. 

![Unwrapped optional](img/unwrapped.png)

The `else` statement is executed if the value _was_ `nil`.

This behaviour of checking to see if an optional contains `nil` and assigning to a new value is called "unwrapping", as in "we unwrapped the return value from `translate()`."

----------------

So let's recap. Swift has syntax that seems familiar to developers who have used C-based languages before. However, Swift includes some quirks and niceties, like not having to declare a variable's type. It also has some limitations, like optionals, that are focused on making the language **safer**. 

If you're keen, feel free to keep playing in the playground. Try figuring out how functions with multiple parameters work, or play with `switch` statements.

import Foundation
/*:Alright, lesson 2!

### Overview of last week

* Any lines beginning with `//` are not classed as code, they're _comments_, and are ignored by the computer.
* We can make a named reference to a number, or a collection of characters - these are called variables. In swift we write that as `var something = 1`.
* We can do logic on these variable by using `if` statements. They let us execute code inside some brackets only when the code inside the `if` is true.
* We looked at using `print("thing")` to send text to a user of the program.
* Then we looked at `for in` loops, as a way of running code within brackets multiple times.

So the main topics we're going to cover today are arrays and logic, and then we'll look at types.

### Arrays

Think about the things we learned last week: things in Swift can be integer numbers like `13` or `42`, they can be decimal numbers like `0.5` or `3.14159`, and they can be strings like `"Hello, Artsy!"`. These are called _types_. The next type we're going to cover is the `Array` type.

An array is a special kind of type because it's a _container_ for other things. An array is a list. It can be a list of numbers, or a list of strings, it can be a list of other lists! Let's see what an array of the numbers one through five looks like.

*/

[1, 2, 3, 4, 5]
/*:

Cool! This is a list of integers. We can make a list of strings, too:

*/

["Ash", "Eloy", "Maxim", "Orta", "Sarah"]
/*:

That's an array of the Artsy mobile team members' names. Cool! And just like the other types we learned about last week, arrays can be stored in variables. 

*/

let names = ["Ash", "Eloy", "Maxim", "Orta", "Sarah"]
/*:

Arrays can be used to store anything; in Artsy, we store things like an artist's artworks in an array.

And remember `for in` loops? Where we had `for in 0..<10`? Well we can do `for in` loops with arrays, too:

*/

for number in [1, 2, 3, 4, 5] {
    print(number)
}
/*:

We can combine variables and loops together; remember that a variable can be used anywhere a regular value can be. If we wanted to say "hello" to everyone on Artsy's mobile team, we could write the following:

*/

for name in names {
    print("Hello, \(name)!")
}
/*:

When Artsy shows users the Artist page, we have the artist's artworks stored in a variable. We use `for in` loops to loop over the array containing the those artworks in order to show them to the user. 

To recap: arrays are a special kind of type because they can contain multiple values. But they can be used in variables like normal types, and they can also be used in `for in` loops. Cool!

### Bools

When we think of how to store data, we can think about how many values can be stored in a type. There are infinite combinations of letters, so a string variable could contain _anything_. Similar with numbers – the value of a number could be anything! But what about other types, are there any that you can think of that have a _limited_ number of values? 

There is such a type, called a bool (or "boolean"). Bool values are pretty easy to work with because they can only be either `true` or `false`. 

*/

var isArtworkForSale = true
var isArtworkOnHold = false
/*:

Swift knows that a bool can only be true or false, unlike with numbers or strings or arrays, which could be anything. If we tried to store the string `"maybe"` in a bool, Swift wouldn't let us.

### Iffy Logic

Ok, we have two variables. Variables work really nicely with `if` statements.

*/

if isArtworkForSale {
    // Show the "Inquire" button
    print("Click to Inquire")
}
/*:

This will check if `isArtworkForSale` is true, and if so it would show the inquire button. We can see if an artwork is _not_ for sale, too:

*/

if isArtworkForSale == false {
    print("Artwork is not inquirable")
}
/*:

`if` statements can be powerful. We've been using only the simplest part so far – next we're going to look at `else`, which bolts on to an `if` and provides a way of running some code when the `if` fails.

*/

if isArtworkForSale {
    print("Click to Inquire")
} else {
    print("Artwork is not inquirable")
}
/*:

So what we're looking at, in plain English: _if the artwork is for sale, present the inquire button, otherwise say the artwork isn't for sale_. 

We can use an `if` and an ` else` statement to represent very complicated logic, but `if`s can do one more thing. Let's introduce a third variable into our mix. It's possible that an artwork can be on hold, too:

*/

isArtworkOnHold = false
/*:

Let's update our `if` statements.

*/

if isArtworkForSale {
    print("Click to Inquire")
} else if isArtworkOnHold {
    print("Artwork is on hold, try asking nicely")
} else {
    print("Artwork is not inquirable")
}
/*:

This is an `else if` statement. It allows programmers to keep some of the logic in `if` statements manageable. Let's try say this in English:

* If the artwork is for sale, show the inquire button.
* Else if it's on hold, tell the user it's on hold.
* Otherwise, tell the user it's not inquirable.

These few key words give us enough options to map out a lot of really complicated cases. However, it's not the only tool in our belt. We'll talk about Boolean Logic after the break.

### Gates

Anyone know why we call a `true`/`false` switch a `Bool`? They're named after a 19th century mathematician who was totally into Algebra. Anyone who has touched electronics will have heard of logic gates. Bools operate on the same principal. We want to represent the case when we're having fun _and_ it's Friday. To do this we want to use the AND operator, named after the AND gate, and symbolized as `&&`.

*/

var isArtworkPriceKnown = true

var showPriceLabel = isArtworkForSale && isArtworkPriceKnown
/*:

So now we have a new `Bool` that is only true when the artwork is both for sale _and_ we know its price. Let's try integrate this into our `if` statements.

*/

if isArtworkForSale {
    print("Click to Inquire")
} else if showPriceLabel {
    print("The artwork costs a million dollars")
} else if isArtworkOnHold {
    print("Artwork is on hold, try asking nicely")
} else {
    print("Artwork is not inquirable")
}
/*:

You might notice that the code above prints "Click to Inquire" instead of the artwork's price. Why? Well, let's interpret our code in English:
 
* If the artwork is for sale, show the inquire button.
* Else if we have a price, show the price label.
* Else if it's on hold, tell the user it's on hold.
* Otherwise, tell the user it's not inquirable.

OK. So the first `if` is not letting our first `else` get through. This is a good time as any to have a think about something as fungible as _code quality_. Programmers spend much more time _reading_ code than _writing_ code. So it's worth taking the time to make sure it reads really nicely.

*/

if isArtworkForSale {
    print("Click to Inquire")
    
    if showPriceLabel {
        print("The artwork costs a million dollars")
    } else if isArtworkOnHold {
        print("Artwork is on hold, try asking nicely")
    } 
} else {
    print("Artwork is not inquirable")
}
/*:

We can also have code that checks if something _or_ something else is true.

*/

var unlikelyToBuyThis = isArtworkOnHold || (isArtworkForSale == false)
/*:

`||` is the OR operator, and it's true if either the left or right side are true. You can see how we combine it with comparing to `false`, too.

### Multiple States of Mind

We have a `Bool` and it can represent one of two states. What could we use to represent something that can only something from a finite a number of states. 

At first glance when we modelled an Artwork in code, we might think to represent the for sale availability as a `Bool`. It's pretty intuitive that an artwork is either sold or not.

*/

// Representing Artwork Availability

isArtworkForSale = true
/*:

However, then someone tells you that the artwork is on hold. You think, "ok, lets add a 'isArtworkOnHold'"

*/

isArtworkOnHold = true
/*:

Well now you can have an Artwork that is on hold, and for sale. This is possible, but feels weird. Think about this: using two bools, we could have a situation like this:

*/

isArtworkOnHold = true
isArtworkForSale = false
/*:

That doesn't make a lot of sense, how can it be on hold _and_ for sale? Wait, an artwork can also be _sold_. Ouch, another `Bool`:

*/

var isArtworkSold = true
/*:

OK, now we can end up in a _really_ strange place. With all these bools, we could end up with competing logic, e.g.: artwork is for sale and it's on hold and it's sold. Not cool. 

The reason this feels weird is because these different states of the artwork are mutually exclusive. Remember how strings and numbers can be any value, but bools can only be `true` or `false`? Just two values. It would be ideal, then, to have some way to represent a finite number of mutually exclusive values. For that, we'll use an enumeration, or `enum`.

*/

enum ArtworkAvailablility {
    case NotForSale
    case ForSale
    case OnHold
    case Sold
}
/*:

This acts like a `Bool` in that it _must_ be exactly one of these four states. For example, it cannot be both for sale and on hold just like a bool can't be both true and false. This is the actual code we use in the [Artsy iOS app](https://github.com/artsy/eigen/blob/master/Artsy/Models/API_Models/Partner_Metadata/Artwork.h#L13-L18), albeit in Objective-C. Same, same.

So let's set it.

*/

var artworkAvailability = ArtworkAvailablility.NotForSale
/*:

Then dig into it a bit in an `if` statement.

*/

if artworkAvailability == .NotForSale {
    print("Not for you.")
}
/*:

Using an `enum` we can represent that something can be one of many states. This comes in handy most when trying to model abstractions that have exclusive states.

With that, I think we have all we need to try and represent an `Artwork`.

### Construction

An `Artwork` is a _reallllly_ complicated thing that we are going to try and model. So let's handle a subset of it's information. An `Artwork` should have a name, an availability and a medium. This is the 21st century, having an Artist is so last century. We're going to use a concept called a `struct` to represent this. A `struct` is a way of collecting some language primitives into a single model. By primitives I mean things like `Bool`s, `Int`s and `String`s, things the language gives us to build on top of.

*/

// Constructing a model of reality

struct Artwork {
    var name: String
    var medium: String
    var availability: ArtworkAvailablility
}
/*:

Let's create one. If you write `var something = Artwork(` it will offer to auto-fill in the details.

*/

var ortasGIF = Artwork(name: "Orta's GIF", medium: "Graphics Interchange Format", availability: .ForSale)
/*:

We can access any of the variables inside the `ortasGIF` by using the `.` character. So if we wanted the name, we could do `ortasGIF.name`, if we wanted the medium, `ortasGIF.medium`. Let's combine what we know by checking if an artwork is a GIF.

*/

if ortasGIF.medium == "Graphics Interchange Format" {
    print("Text is such a boring medium for GIFs")
}
/*:

Nice. OK. Let's wrap up.

### Overview

In lesson one, we learned about some of the primitives that Swift gives us. Mainly `Int`s and `String`s, and how to use an `if` and `for` to run different code paths.
In lesson two we have:

* Expanded our knowledge of primitives to include a `Bool`. Which represents one of two states, on or off, `true` or `false`.
* Built on `if` to include `else if` and `else` statements. These let us represent a lot of common code flows.
* Done some boolean algebra via `||` and `&&`.
* Found a way to represent exclusive states using an `enum`
* Talked about how we can model a concept like an `Artwork` via a `struct`. We built on the swift primitives to create a model that represents something important to our hearts.

If you're keen, try to apply some of the things we learned last week with bools, `if` statements, logic, and `structs`. Here are some questions:

- How might an artwork have an artist? How would you model an `Artist` struct?
- We saw that enums and bools are similar. Do you think that bools could themselves _be_ an enum? Why or why not?
- What if an artwork had to have multiple artists? How would that work?
*/
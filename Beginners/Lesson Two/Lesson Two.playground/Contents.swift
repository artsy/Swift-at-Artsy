//: Alright, lesson 2!
//: 
//: ### Overview of last week
//: 
//: * Any lines beginning with `//` are not classed as code, and are ignored.
//: * We can make a named reference to a number, or a collection of characters - these are called variables. In swift we write that as `var something = 1`.
//: * We can do logic on these variable by using `if` statements. They let us execute code inside some brackets only when the code inside the `if` is true.
//: * We looked at using `print("thing")` to send text to a user of the program.
//: * Then we looked at `for` loops, as a way of running code within brackets multiple times, or as a way of running through a collection of items.
//: 
//: So the main topic we're going to cover today is logic and then we'll look at types.
//: 
//: ### Bools
//: 
//: In the last lesson we used a lot of variables. A variable is a way in which we could label something that can change. The variables we used were numbers (`Int`s) or collections of characters (`String`s). What about when a variable should only be a certain type of data. Let's look at an on/off value (`Bool`). These are pretty easy to work with, they can either be `true` or `false`. Lets make some.
var isThisExcitingYet = false
//: Alright cynic. Let's do something more interesting.
var areYouMean = true
//: ### Iffy Logic
//: 
//: Ok, we have two variables. These work really nicely with `if` statements.
if isThisExcitingYet {
  print("🎉")
}
//: This will check if it's fun yet, and if so Xcode will print a party popper. We could cheat and instead check if it's false, then we get a free party popper.
if isThisExcitingYet == false {
  print("🎉")
}
//: However, we can do it right. `if` statements can be powerful. We've been using only the simplest part so far. We're going to look at `else`, which bolts on to an `if` and provides a way of running some code when the `if` fails.
// OK, we have a way to protect against boredom.

if isThisExcitingYet {
  print("🎉")
} else {
  print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}
//: So what we're looking at, in plain English: _if something is exciting, show a party popper else recommend a good youtube video_. We can use an `if` and an ` else` statement to represent a very large amount of logic. `if`s have one more thing, that I'd like to go over. Before we do that, we should consider what happens if Andrew WK is in the room.
var isAndrewWKAround = false
//: Well, he would have an important impact on everyone's exciting-ness. Let's try and represent that in our if statement.
// Whoah, Andrew WK?

if isThisExcitingYet {
  print("🎉")
} else if isAndrewWKAround {
  print("Did someone say Party Hard?")
} else {
  print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}
//: This is an `else if` statement. It allows programmers to keep some of the logic in `if` statements sane. Let's try say this in English:
//: 
//: * If it's exciting, party
//: * Else if Andrew WK is around, ask if someone said Party Hard
//: * Otherwise go to youtube
//: 
//: These few key words give us enough options to map out a lot of really complicated cases. However, it's not the only tool in our belt. We'll talk about Boolean Logic after the break.
//: 
//: ### Gates
//: 
//: Anyone know why we call a `true`/`false` switch a `Bool`? They're named after a 19th century mathematician who was totally into algebra. Anyone who has touched electronics will have heard of logic gates. This is the same principal. We want to represent the case of when we're excited and when Andrew WK is in the room. To do this we want to use the AND operator, `&&`.
var thisReallyIsTheMostExcitingThing = isThisExcitingYet && isAndrewWKAround
//: So now we have a new `Bool` that is only true when it is both exciting and Andrew WK is around. Let's try integrate this into our `if` statements.
// Adding in when it's too exciting

if isThisExcitingYet {
  print("🎉")
} else if thisReallyIsTheMostExcitingThing {
  print("No! Time! To! Talk!")
} else if isAndrewWKAround {
  print("Did someone say Party Hard?")
} else {
  print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}
//: OK, let's pretend Andy is here with us... :(. And, err, that this is now exciting. Bare with me.
// Let's change the state of the room

isAndrewWKAround = true
isThisExcitingYet = true
//: So, what gives? Shouldn't we be unable to even talk cause we're partying hard? Well not yet. Let's break this into English:
//: 
//: * If it's exciting, party
//: * Else if Andrew WK is around and it's exciting, we become too busy partying
//: * Else if Andrew WK is around, ask if someone said Party Hard
//: * Otherwise go to youtube
//: 
//: OK. So the first `if` is not letting our else get through. This is a good time as any to have a think about something as fungible as code quality. In the end code is going to be read significantly more times than it will be written. So it's worth taking the time to make sure it reads really nicely.
// A more elegant fix

if thisReallyIsTheMostExcitingThing {
  print("No! Time! To! Talk!")
} else if isThisExcitingYet {
  print("🎉")
} else if isAndrewWKAround {
  print("Did someone say Party Hard?")
} else {
  print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}
//: OK, well what if we want to know if anyone is excited in the room? Yeah, I know, we're stretching this. Well, right now there's all of us, and Andrew. In order to answer this we are wondering "Am I excited, or is Andrew WK in the room?" ( He's always excited BTW. )
//: 
//: ![Giphy](http://media0.giphy.com/media/u9JFWbnYI1Jo4/giphy.gif)
//: 
//: So let's represent it in a var.
// Anyone excited in here?

var isAnyoneExcitedInHere = isThisExcitingYet || isAndrewWKAround
//: Now if either side of the `||` is true then the variable `isAnyoneExcitedInHere` is true. With just `||`, `&&` and our `if`, `if else` and `else` statements we can basically map any boolean logic into code.
//: 
//: ### Multiple States of Mind
//: 
//: We have a `Bool` and it can represent one of two states. What could we use to represent something that can only something from a finite a number of states. For example, at first glance when we are making an Artwork we might think to represent the for sale availability as a `Bool`. It's pretty intuitive that an artwork is either sold or not.
// Representing Artwork Availability
var isArtworkForSale = true
//: However, then someone tells you that the artwork is on hold. You think, "ok, lets add a 'isArtworkOnHold'"
var isArtworkOnHold = true
//: Well now you can have an Artwork that is on hold, and for sale. This is possible, but feels a bit off. Finally you realise that an artwork could be classed as Sold. Ouch, another `Bool`.
var isArtworkSold = true
//: OK, now we can end up in  a really strange place. You could have competing logic, e.g. it's for sale and it's on hold and it's sold. Not cool. We can wrap these in an `enum`.
enum ArtworkAvailablility {
  case NotForSale
  case ForSale
  case OnHold
  case Sold
}
//: This acts like a `Bool` in that it can only be one of these four states, it cannot be both for sale and on hold. This is the actual code we use in the [Artsy iOS app](https://github.com/artsy/eigen/blob/master/Artsy/Models/API_Models/Partner_Metadata/Artwork.h#L13-L18), albeit in Objective-C. Same, same.
//: 
//: So let's set it.
var artworkAvailability = ArtworkAvailablility.NotForSale
//: Then dig into it a bit in an `if` statement.
if artworkAvailability == .NotForSale {
  print("Not for you.")
}
//: Using an `enum` we can represent that something can be one of many states. This comes in handy most when trying to model abstractions that have exclusive states.
//: 
//: With that, I think we have all we need to try and represent an `Artwork`.
//: 
//: ### Construction
//: 
//: An `Artwork` is a _reallllly_ complicated thing that we are going to try and model. So let's handle a subset of it's information. An `Artwork` should have a name, an availability and a medium. This is the 21st century, having an Artist is so last century. We're going to use a concept called a `struct` to represent this. A `struct` is a way of collecting some language primitives into a single model. By primitives I mean things like `Bool`s, `Int`s and `String`s, things the language gives us to build on top of.
// Constructing a model of reality

struct Artwork {
  var name:String;
  var medium: String;
  var availability:ArtworkAvailablility;
}
//: Let's create one. If you write `var something = Artwork(` it will offer to auto-fill in the details.
var ortasGIF = Artwork(name: "Orta's GIF", medium: "Graphics Interchange Format", availability: .ForSale)
//: We can access any of the variables inside the `ortasGIF` by using the `.` character. So if we wanted the name, we could do `ortasGIF.name`, if we wanted the medium, `ortasGIF.medium`. Let's combine what we know by checking if an artwork is a GIF.
if ortasGIF.medium == "Graphics Interchange Format" {
  print("Text is such a boring medium for GIFs")
}
//: Nice. OK. Let's wrap up.
//: 
//: ### Overview
//: 
//: In lesson one, we learned about some of the primitives that Swift gives us. Mainly `Int`s and `String`s, and how to use an `if` and `for` to run different code paths.
//: In lesson two we have:
//: 
//: * Expanded our knowledge of primitives to include a `Bool`. Which represents one of two states, on or off, `true` or `false`.
//: * Built on `if` to include `else if` and `else` statements. These let us represent a lot of common code flows.
//: * Done some boolean algebra via `||` and `&&`.
//: * Found a way to represent exclusive states using an `enum`
//: * Talked about how we can model a concept like an `Artwork` via a `struct`. We built on the swift primitives to create a model that represents something important to our hearts.

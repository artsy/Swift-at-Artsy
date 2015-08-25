Alright, lesson 2!

### Overview of last week

vars/if/for/print

So the main topic we're going to cover today is logic and then we'll look at types.

### Bools

In the last lesson we used a lot of variables. A variable is a way in which we could label something that can change. The variables we used were numbers (`Int`s) or collections of characters (`String`s). What about when a variable should only be a certain type of data. Let's look at an on/off value (`Bool`). These are pretty easy to work with, they can either be `true` or `false`. Lets make some.

``` swift
var isThisExcitingYet = false
```

Alright cynic. Let's do something more interesting.

``` swift
var isThisExcitingYet = false
var areYouMean = true
```

### Iffy Logic

Ok, we have two variables. These work really nicely with `if` statements.

``` swift
var isThisExcitingYet = false
var areYouMean = true

if isThisExcitingYet {
  print("🎉")
}
```

This will check if it's fun yet, and if so Xcode will print a party popper. We could cheat and instead check if it's false, then we get a free party popper.

``` swift
if isThisExcitingYet == false {
  print("🎉")
}
```

However, we can do it right. `if` statements can be powerful. We've been using only the simplest part so far. We're going to look at `else`, which bolts on to an `if` and provides a way of running some code when the `if` fails.

``` swift
# OK, we have a way to protect against boredom.

if isThisExcitingYet {
  print("🎉")
} else {
  print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}
```

So what we're looking at, in plain English: _if something is exciting, show a party popper else recommend a good youtube video_. We can use an `if` and an ` else` statement to represent a very large amount of logic. `if`s have one more thing, that I'd like to go over. Before we do that, we should consider what happens if Andrew WK is in the room.

``` swift
var isAndrewWKAround = false
```

Well, he would have an important impact on everyone's exciting-ness. Let's try and represent that in our if statement.

``` swift
# Whoah, Andrew WK?

if isThisExcitingYet {
  print("🎉")
} else if isAndrewWKAround {
  print("Did someone say Party Hard?")
} else {
  print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}
```

This is an `else if` statement. It allows programmers to keep some of the logic in `if` statements sane. Let's try say this in English:

* If it's exciting, party
* Else if Andrew WK is around, ask if someone said Party Hard
* Otherwise go to youtube

These few key words give us enough options to map out a lot of really complicated cases. However, it's not the only tool in our belt. We'll talk about Boolean Logic after the break.

### Gates

Anyone know why we call a `true`/`false` switch a `Bool`? They're named after a 19th century mathematician who was totally into algebra. Anyone who has touched electronics will have heard of logic gates. This is the same principal. We want to represent the case of when we're excited and when Andrew WK is in the room. To do this we want to use the AND operator, `&&`.

``` swift
var thisReallyIsTheMostExcitingThing = isThisExcitingYet && isAndrewWKAround
```

So now we have a new `Bool` that is only true when it is both exciting and Andrew WK is around. Let's try integrate this into our `if` statements.

``` swift
# Adding in when it's too exciting

if isThisExcitingYet {
  print("🎉")
} else if thisReallyIsTheMostExcitingThing {
  print("No! Time! To! Talk!")
} else if isAndrewWKAround {
  print("Did someone say Party Hard?")
} else {
  print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}
```

OK, let's pretend Andy is here with us... :(. And, err, that this is now exciting. Bare with me.

``` swift
# Let's change the state of the room

isAndrewWKAround = true
isThisExcitingYet = true
```

So, what gives? Shouldn't we be unable to even talk cause we're partying hard? Well not yet. Let's break this into English:

* If it's exciting, party
* Else if Andrew WK is around and it's exciting, we become too busy partying
* Else if Andrew WK is around, ask if someone said Party Hard
* Otherwise go to youtube

OK. So the first `if` is not letting our else get through. This is a good time as any to have a think about something as fungible as code quality. In the end code is going to be read significantly more times than it will be written. So it's worth taking the time to make sure it reads really nicely.

``` swift
# A more elegant fix

if thisReallyIsTheMostExcitingThing {
  print("No! Time! To! Talk!")
} else if isThisExcitingYet {
  print("🎉")
} else if isAndrewWKAround {
  print("Did someone say Party Hard?")
} else {
  print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}
```

OK, well what if we want to know if anyone is excited in the room? Yeah, I know, we're stretching this. Well, right now there's all of us, and Andrew. In order to answer this we are wondering "Am I excited, or is Andrew WK in the room?" ( He's always excited BTW. )

![Giphy](http://media0.giphy.com/media/u9JFWbnYI1Jo4/giphy.gif)

So let's represent it in a var.

``` swift
# Anyone excited in here?

var isAnyoneExcitedInHere = isThisExcitingYet || isAndrewWKAround
```

### Classes / Structures

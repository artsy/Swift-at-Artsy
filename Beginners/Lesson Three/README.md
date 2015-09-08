OK, lesson 3!

### Overview of last week

* Expanded our knowledge of primitives to include a `Bool`. Which represents one of two states, on or off, `true` or `false`.
* Built on `if` to include `else if` and `else` statements. These let us represent a lot of common code flows.
* Done some boolean algebra via `||` and `&&`.
* Found a way to represent exclusive states using an `enum`
* Talked about how we can model a concept like an `Artwork` via a `struct`. We built on the swift primitives to create a model that represents something important to our hearts.

So the main topic we're going to cover today is expanding our concepts of `struct`, and what we call Object Oriented Programming.

### Schools of Thought

Like the Art world there are schools of thought among craftspeople. Programming has existed for about 60 years and has migrated from rotating some cogs in Alan Turing's Enigma machine, to punch cards, to Grace Hopper's magnetic tape and finally to it's current form of text. Since then people have cared more for the abstractions of how code _should_ be formatted than the underlying medium to transmit the information.

We're going to concentrate on Object Oriented Programming. If any school of thought "won" it's that. It's ubiquitously used in almost all major programming languages as a way of encapsulating concepts as language features. We've already done some Object Oriented Programming last week. It's got a low barrier to entry, and tends to gel well to how people think about the world.

Note, there are, like, a million schools of thought, called methodologies or programming paradigms. None are "right", all are equally interesting and valid. For example the creators of Swift said that they believe that swift is a Protocol Oriented Programming language, Ash is a proponent of Functional Reactive Programming ( he's done a [great beginner-level](https://realm.io/news/altconf-ash-furrow-functional-reactive-swift/) talk on it, it might go a bit over your heads but it's maybe worth a look for homework. ) These are different approaches to the same problem and are [all equally worth looking at](https://twitter.com/dbgrandi/status/508329463990734848).

### wOOP

Let's look at what we did last week with a struct:

``` swift
struct Artwork {
    var name: String
    var medium: String
    var availability: ArtworkAvailablility
}
```

What we did here was we created a blueprint to describe what we think an Artwork should be. This bit of code declares that we want to _be able_ to create Artworks, that will contain; a name, a medium and an availability. It does not create one. Only provides a mapping for the concept. The proper terminology here, is that we have created an Artwork type. We used the Artwork type to represent the variables that an individual Artwork could have. However types can do more than that, in order to understand the next bit we have to take a detour to learn a new concept, functions.

### Keepin' It Functional

So far we've cared about variables. Very, very often there's a need to perform common actions within your code. Think of it as being similar to words, you have a base vocabulary but then as you learn of a new word it encapsulates an new idea in a way that you can just that word to refer to an idea. 

For example, the concept of "the realization that each random passerby is living a life as vivid and complex as your own" is a lot to say, then when you understand that the word for this concept, "Sonder" exists, there is a single word concept that represents an idea. Functions are a bit like this. We're going to start small, so I'm afriad this example will be a bit contrived, but don't worry, we're going to build it into a simplified version of something [from Eidolon](https://github.com/artsy/eidolon/blob/master/Kiosk/App/Models/Artwork.swift#L111)!

``` swift
func printArtworkSubtitle() {
  print("Artwork name, date")
}
```

Similar to when we created a struct, this is a declaration of something, it is not code that is ran ( as we can see in the right hand side. ) Let's look at what we've got here:

* `func` is short for function. We call these little declarations of code a function. Functions have a name and can run some code inside their braces. Optionally, they can have inputs and outputs.
* `printArtworkSubtitle` is the name of the function. Ideally you want this to describe the code inside the braces pretty well, but it is a summary so it allows for some ambiguity.
* `()` says that we have no inputs to the function
* `{ .. }` is the code that is going to be ran


> *Note*: another take on the metaphors for functions was provided by Chris Eidhof on [twitter](https://twitter.com/chriseidhof/status/638698203257438208):

> * it’s like learning words: once you have extended the vocabulary, you can just use that word (or function).
* wrong abstraction level makes things incomprehensible. For example: during a soccer, you just want to shout: kick me the ball.
* too much abstraction (let's win) won't help, too little (bend your leg back, move your foot towards the ball) won't help either

Alright. So we've declared that a function exists. We want to be able to use it. We can use it by writing it's name, and adding braces.

``` swift
printArtworkSubtitle()
```

This will print out `"Artwork name, date"` - great. We've encapsulated a concept behind a smaller description. Let's start making it useful by providing some inputs. Let's send in an artists name, and a date. To do that we have to change the function declaration to add an artwork name.

``` swift
func printArtworkSubtitle(artworkName: String) {
  print(artworkName)
}
```

We've said that we're going to have a variable inside the function's braces called `artworkName`. We then `print`'d it. We need to make a corrosponding change in how we call the function. Now we call it by doing:

``` swift
printArtworkSubtitle("Untitled #23")
```

We send in a string to the function. This string internally is know as `artworkName` in the declaration above, and is printed out. However, we just forgot our date. So, let's add that back in.

``` swift
func printArtworkSubtitle(artworkName: String, artworkDate: String) {
    print(artworkName)
    print(artworkDate)
}
```

Nothing too odd here, we use commas to separate the different inputs. The odd bit is actually in how we call it. 

``` swift
printArtworkSubtitle("Untitled #23", artworkDate: "1985")
```

Calling the function also is a comma separated list, but after the 1st thing in the list we write the name of what the variable is going to be. This is different to most languages, which would write: `printArtworkSubtitle("Untitled #23", "1985")`. Swift duses labels for things to make it easy to know what all of the inputs stand for. It's about making it easier to read. We call the commas separated list of things going in to a function the "function's parameters" and the named ones a "labeled parameter."

Knowing what to put in a functions parameters is basically a skill you learn over the years, but as I've done it for years we'll skip to what I want. I know that both of those bits of information can be found on an Artwork. So rather than providing two parameters, we could provide just one. Less, in general, is better. There's nuance there though. To do this we need to include a date string on the Artwork Type.

``` swift
struct Artwork {
    var name: String
    var medium: String
    var availability: ArtworkAvailablility
    var date: String
}
```

OK. That's a date. Let's change our function to take any instance of an Artwork.

``` swift
func printArtworkSubtitle(artwork: Artwork) {
    print(artwork.name)
    print(artwork.date)
}
```

Now, we can create an Artwork. We're going to start trying to represent real data. So we're gonna use my favourite artist, [Glenn Brown](https://www.artsy.net/artist/glenn-brown)

``` swift 
// https://www.artsy.net/artwork/glenn-brown-death-disco

var disco = Artwork(name: "Death Disco", medium: "Oil on Panel", availability: .NotForSale, date: "2004")
```

OK, great. So let's print the subtitle for the artwork.

``` swift
printArtworkSubtitle(disco)
```

Let's recap. We've created a function that has an input of an Artwork type. This function looks inside the artwork to print out it's name, and it's date. This means whenever we want to print an artworks subtitle we can do so really easy, and very importantly, consistently. 

### WhOOPs

So let's get back to our `struct` Artwork. We were talking about how it contains variables. Well, they can also contain functions too. From my perspective, it is the job of the Artwork to decribe itself. So we're going to move the `printArtworkSubtitle` function into the Artwork struct.

``` swift
struct Artwork {
    var name: String
    var medium: String
    var availability: ArtworkAvailablility
    var date: String

    func printArtworkSubtitle(artwork: Artwork) {
        print(artwork.name)
        print(artwork.date)
    }
}
```

done. Ish. This still works fine. We can see this by doing:

```
disco.printArtworkSubtitle(disco)
```

However Types come with a sneaky variable that can be used to reduce the amount of code we have to write. This variable is called `self`, and when you are using it, it refers to the _instance_ of which the function is attached. So instead of passing in an artwork, we can use the one that comes in implicitly.

``` swift
struct Artwork {
    var name: String
    var medium: String
    var availability: ArtworkAvailablility
    var date: String

    func printSubtitle() {
        print(self.name)
        print(self.date)
    }
}
```

So what we have done is added some behavior to our Artwork type. 

### Overview

In lesson one, we learned about some of the primitives that Swift gives us. Mainly `Int`s and `String`s, and how to use an `if` and `for` to run different code paths.
In lesson two, we improved our primitive knowledge with Bools, and enums. Did a lot of `if` statements and some boolean algebra. Then started using `struct`s to represent ideas.

In lesson three, we have

* Talked about programming paradigms
* Looked at functions
* Shown how a function can be added to a Type

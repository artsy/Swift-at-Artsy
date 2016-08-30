# Lesson Three 

Alright, we're back. 

I feel like I want to stay in the command-line for a little bit longer. Perhaps this plus one more lesson.

We're going to start with a game. It's one we all know, I hope. Rock, Paper, Scissors (RPS.) 

RPS should be a good game to work at with our prior knowledge, it's going to require some data modelling, some input handling and some game logic.

Let's start off by making a new Cocoa project in Xcode. The instructions for this is available in [Lesson Two](https://github.com/artsy/Swift-at-Artsy/tree/master/Fledgling/Lesson%20Two#xcode).

So, inside our new Xcode project, open `Main.swift`.  

### Scope

We're going to start with the data modelling. Let's consider, what things are we going to need to model?

* There are two players, you and the computer
* Each player chooses one of three options
* Once each player has made a choice, decide the winner
* Announce the winner

So, looking at those observations, how would you model the choices?

As this is a text document, I don't get the ability to hear you back, so I'm gonna assume you get the answer. This is a great case for an `enum` - it can only be one of three things. So, let's write an `enum`.

```swift
enum PlayerChoice {
    case Rock
    case Paper
    case Scissors
}
```

## Hello, World

Let's move on to creating our games title screen. This sets the scene for how good your game is. So, I searched for [ASCII art generator](https://duckduckgo.com/?q=ASCII+generator&t=osx&ia=web). I made this badass logo.

```swift
print(" ")
print("____________________  _________                           ")
print("\______   \______   \/   _____/            ___.__. ____   ")
print(" |       _/|     ___/\_____  \    ______  <   |  |/  _ \  ")
print(" |    |   \|    |    /        \  /_____/   \___  (  <_> ) ")
print(" |____|_  /|____|   /_______  /            / ____|\____/  ")
print("        \/                  \/             \/             ")
print(" ")
``` 

People will know I mean business now.



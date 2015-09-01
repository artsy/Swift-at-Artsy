//: Playground - noun: a place where people can play

import Cocoa

var isThisExcitingYet = false

var doImeanIt = true

if (isThisExcitingYet) {
    print("🎉")
} else {
    print("🐔")
}

// OK, we have a way to protect against boredom.

if isThisExcitingYet {
    print("🎉")
} else {
    print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}

var isAndrewWKAround = true

// Whoah, Andrew WK?

if isThisExcitingYet {
    print("🎉")
} else if isAndrewWKAround {
    print("Did someone say Party Hard?")
} else {
    print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}



// Adding in when it's too exciting

var thisReallyIsTheMostExcitingThing = isThisExcitingYet && isAndrewWKAround

if isThisExcitingYet {
    print("🎉")
} else if thisReallyIsTheMostExcitingThing {
    print("No! Time! To! Talk!")
} else if isAndrewWKAround {
    print("Did someone say Party Hard?")
} else {
    print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}

// Let's change the state of the room

isAndrewWKAround = true
isThisExcitingYet = true
thisReallyIsTheMostExcitingThing = isThisExcitingYet && isAndrewWKAround


if isThisExcitingYet {
    print("🎉")
} else if thisReallyIsTheMostExcitingThing {
    print("No! Time! To! Talk!")
} else if isAndrewWKAround {
    print("Did someone say Party Hard?")
} else {
    print("Please visit https://www.youtube.com/results?search_query=andrew%20wk")
}


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

// Anyone excited in here?

var isAnyoneExcitedInHere = isThisExcitingYet || isAndrewWKAround



// Representing Artwork Availability

var isArtworkForSale = true
var isArtworkOnHold = true
var isArtworkSold = true


// A better way

enum ArtworkAvailablility {
    case NotForSale
    case ForSale
    case OnHold
    case Sold
}

var artworkAvailability = ArtworkAvailablility.NotForSale

if artworkAvailability == .NotForSale {
    print("Not for you.")
}

// Constructing a model of reality

struct Artwork {
    var name:String;
    var medium: String;
    var availability:ArtworkAvailablility;
}

var ortasGIF = Artwork(name: "Orta's GIF", medium: "Graphics Interchange Format", availability: .ForSale)

if ortasGIF.medium == "Graphics Interchange Format" {
    print("Text is such a boring medium for GIFs")
}
//: Playground - noun: a place where people can play

import Cocoa

// Mapping Artsy

enum ArtworkAvailablility {
    case NotForSale
    case ForSale
    case OnHold
    case Sold
}

// struct Artwork {
//     var name: String
//     var medium: String
//     var availability: ArtworkAvailablility
// }

// Initial look at a subtitle

func printArtworkSubtitle() {
    print("Artwork name, date")
}

printArtworkSubtitle()

// Including a single parameter

func printArtworkSubtitle(artworkName: String) {
    print(artworkName)
}

printArtworkSubtitle("Untitled #23")

// Using two parameters

func printArtworkSubtitle(artworkName: String, artworkDate: String) {
    print(artworkName)
    print(artworkDate)
}

// Using the labeled parameter for date

printArtworkSubtitle("Untitled #23", artworkDate: "1985")

// https://www.artsy.net/artwork/glenn-brown-death-disco

// var disco = Artwork(name: "Death Disco", medium: "Oil on Panel", availability: .NotForSale, date: "2004")

// func printArtworkSubtitle(artwork: Artwork) {
//     print(artwork.name)
//     print(artwork.date)
// }
// printArtworkSubtitle(disco)

// Initial look at migrating our function into a type

// struct Artwork {
//     var name: String
//     var medium: String
//     var availability: ArtworkAvailablility
//     var date: String
//
//     func printArtworkSubtitle(artwork: Artwork) {
//         print(artwork.name)
//         print(artwork.date)
//     }
// }
//
// disco.printArtworkSubtitle(disco)

// An elegant answer to printing the subtitle:

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


var disco = Artwork(name: "Death Disco", medium: "Oil on Panel", availability: .NotForSale, date: "2004")
disco.printSubtitle()

//: Playground - noun: a place where people can play

import Cocoa

struct Partner {
    var name:String;
}

struct Artwork {
    var name: String
    var medium: String
    var availability: String
    var date: String
    var height: Int
}

struct Show {
    var name: String
    var location: String
    var openingDate: NSDate
    var closingDate: NSDate
    var partner: Partner
    var artworks: [Artwork]

    func drawInstallationImage() {
        print("----------------------------------------------")
        print("")
        print("           [  ] [  ] [  ] [  ] [  ]")
        print("")
        print("----------------------------------------------")
        print("                   * * * * *")
        print("")
    }

    func drawShowRange() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd"
        let end = formatter.stringFromDate(self.openingDate)
        let start = formatter.stringFromDate(self.closingDate)
        print("\(end) - \(start)")
    }
}

struct ShowPage {
    var show: Show

    func drawPage() {
        self.show.drawInstallationImage()
        self.drawShareButton()
        self.drawPartnerCallToAction()
        print(self.show.name)
        self.show.drawShowRange()
        print(self.show.location)

        for artwork in self.show.artworks {
            print("")
            print("   ---------------------------------------")
            for _ in 0 ..< artwork.height {
                print("   [                                     ]")
            }
            print("   ---------------------------------------")
            print("   \(artwork.name)")
        }
    }

    func drawShareButton() {
        print("                                     [ ^ ]")
    }

    func drawPartnerCallToAction() {
        print("\(self.show.partner.name)          [ FOLLOW GALLERY ]")
    }
}

var formatter = NSDateFormatter()
formatter.dateFormat = "dd-mmm-yyyy"

var startDate = formatter.dateFromString("14-04-2015")!
var endDate = formatter.dateFromString("6-09-2015")!

var defender = Artwork(name: "Defender Argo", medium: "Print", availability: "For Sale", date: "1910", height: 3)
var burke = Artwork(name: "Burke & James Rexo", medium: "Print", availability: "For Sale", date: "1910", height: 5)

var partner = Partner(name: "Yossi Milo Gallery")
var show = Show(name: "Light, Paper, Process: Reinventing Photography", location: "The J.Paul Getty Museum, LA", openingDate: startDate, closingDate: endDate, partner: partner, artworks: [defender, burke])

var showPage = ShowPage(show: show)
showPage.drawPage()

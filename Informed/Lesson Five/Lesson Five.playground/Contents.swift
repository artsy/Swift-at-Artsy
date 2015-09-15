// Lesson Five

// Error-handling

class CreditCard {
    var remainingCredit: Int = 0
}

struct Inventory {
    struct Item {
        var price: Int
        var stock: Int
    }

    enum Error: ErrorType {
        case ItemNotFound
        case OutOfStock
        case InsufficientFunds(requiredBalance: Int)
    }

    var items: [String: Item]

    mutating func buyItemNamed(name: String, withCreditCard creditCard: CreditCard) throws -> Item {
        if var item = items[name] {
            if item.stock > 0 {
                if creditCard.remainingCredit >= item.price {
                    creditCard.remainingCredit -= item.price
                    item.stock--
                    items[name] = item
                    return item
                } else {
                    throw Inventory.Error.InsufficientFunds(requiredBalance: item.price)
                }
            } else {
                throw Inventory.Error.OutOfStock
            }
        } else {
            throw Inventory.Error.ItemNotFound
        }
    }
}

var inventory = Inventory(items: [
    "shirt": Inventory.Item(price: 20, stock: 4),
    "pants": Inventory.Item(price: 40, stock: 8),
    "shoes": Inventory.Item(price: 50, stock: 2)
])

let creditCard = CreditCard()
creditCard.remainingCredit = 100

func buyThing() {
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
}

buyThing()

if let purchasedItem = try? inventory.buyItemNamed("pants", withCreditCard: creditCard) {
    print("Bought some pants: \(purchasedItem)")
}

// Don't do this!!!
//try! inventory.buyItemNamed("shoes", withCreditCard: creditCard)

// guard statements

struct InventoryV2 {
    struct Item {
        var price: Int
        var stock: Int
    }

    enum Error: ErrorType {
        case ItemNotFound
        case OutOfStock
        case InsufficientFunds(requiredBalance: Int)
    }

    var items: [String: Item]

    mutating func buyItemNamed(name: String, withCreditCard creditCard: CreditCard) throws -> Item {
        defer {
            // Always thank our customers.
            print("Thanks for shopping at $STORE_NAME!")
        }

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

// Throwing Closures

let a = { () throws -> () in

}

try a()

// Rethrowing

func f(callback: () throws -> Void) rethrows {
    try callback()
}

func s() {
    // Closure doesn't throw, so I don't have to catch.
    f { () -> Void in
        print("hi!")
    }
}

func t() {
    // Closure _does_ throw, so now I have a mess to deal with.
    do {
        try f { () -> Void in
            try inventory.buyItemNamed("t", withCreditCard: creditCard)
        }
    } catch {
        print("Something went wrong!")
    }
}

// map is marked as rethrows, too!
[1, 2, 3].map { (t) -> String in
    "\(t)"
}

try ["shirt", "shoes", "pants"].map { name -> Inventory.Item in
    return try inventory.buyItemNamed(name, withCreditCard: creditCard)
}

// Functional programming

func add(lhs: Int, _ rhs: Int) -> Int {
    return lhs + rhs
}

add(2, 3)

let someVariable = add
let parameters = (2, 3)
someVariable(parameters)

func subtract(operand: Int, fromNumber number: Int) -> Int {
    return number - operand
}

subtract(3, fromNumber: 10)

let someOtherVariable = subtract
let newParameters = (3, fromNumber: 10)
someOtherVariable(newParameters)


// Long-hand syntax, boooo hissss
//func contains(suspect: Character) -> (String -> Bool) {
//    return { string -> Bool in
//        return string.characters.contains(suspect)
//    }
//}

func contains(suspect: Character)(string: String) -> Bool {
    return string.characters.contains(suspect)
}

let input = ["ash@example.com", "orta at example.com", "jory@example.com"]
input.filter(contains("@"))

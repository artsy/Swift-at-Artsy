/// Operator Overloading

func +<T>(lhs: T, rhs: [T]) -> [T] {
    var value = rhs
    value.insert(lhs, atIndex: 0)
    return value
}

"a" + ["b"]

/// Extensions

extension Int {
    func times(closure: () -> ()) {
        (0..<self).forEach { _ in closure() }
    }
}

4.times { () -> () in
    print("hi!")
}

/// Protocol Extensions

protocol Occupiable {
    var isEmpty: Bool { get }
    var isNotEmpty: Bool { get }
}

extension Occupiable {
    var isNotEmpty: Bool {
        return !isEmpty
    }
}

struct Stack<T> {
    private var contents = Array<T>()

    mutating func push(input: T) {
        contents.append(input)
    }

    mutating func pop() -> T {
        return contents.removeLast()
    }
}

extension Stack: Occupiable {
    var isEmpty: Bool {
        return contents.isEmpty
    }
}

var stack = Stack<String>()
stack.push("hi!")
stack.isEmpty
stack.isNotEmpty



extension String: Occupiable { }

extension CollectionType where Self: Occupiable { } // Note: This does NOTHING.

extension Array: Occupiable { }
extension Dictionary: Occupiable { }
extension Set: Occupiable { }

extension Stack where T: Occupiable {
    // Something neat in here
}

extension Optional where Wrapped: Occupiable {
    var isNilOrEmpty: Bool {
        switch self {
        case .None:
            return true
        case .Some(let value):
            return value.isEmpty
        }
    }

    var isNotNilNotEmpty: Bool {
        return !isNilOrEmpty
    }
}





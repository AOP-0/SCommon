

import Foundation


@propertyWrapper
struct trimChar{
    private var str: String
    private var char: CharacterSet

    var wrappedValue: String {
        get{
            str.trimmingCharacters(in: char)
        }
        set{
            str = newValue
        }
    }
    init(wrappedValue: String, char: CharacterSet? = .whitespacesAndNewlines) {
        self.char = char!
        self.str = wrappedValue
    }
}


@propertyWrapper
struct NSLockP<T>{
    private let lock = NSLock()
    private var t: T

    var wrappedValue: T {
        get{
            defer {
                lock.unlock()
            }
            lock.lock()
            return t
        }
        set{
            defer {
                lock.unlock()
            }
            lock.lock()
            t = newValue
        }
    }
    init(wrappedValue: T) {
        t = wrappedValue
    }
}

@propertyWrapper
struct strPreMax{
    private var count: Int
    private var str: String

    var wrappedValue: String {
        get{
            str
        }
        set{
            str = String(newValue.prefix(count))
        }
    }
    init(wrappedValue: String, count: Int) {
        self.count = count
        str = String(wrappedValue.prefix(count))

    }
}

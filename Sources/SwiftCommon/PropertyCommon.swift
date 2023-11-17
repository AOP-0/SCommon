

import Foundation


@propertyWrapper
public struct trimChar{
    private var str: String
    private var char: CharacterSet

    public var wrappedValue: String {
        get{
            str.trimmingCharacters(in: char)
        }
        set{
            str = newValue
        }
    }
    public init(wrappedValue: String, char: CharacterSet? = .whitespacesAndNewlines) {
        self.char = char!
        self.str = wrappedValue
    }
}


@propertyWrapper
public struct NSLockP<T>{
    private let lock = NSLock()
    private var t: T

    public var wrappedValue: T {
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
    public init(wrappedValue: T) {
        t = wrappedValue
    }
}

@propertyWrapper
public struct strPreMax{
    private var count: Int
    private var str: String

    public var wrappedValue: String {
        get{
            str
        }
        set{
            str = String(newValue.prefix(count))
        }
    }
    public init(wrappedValue: String, count: Int) {
        self.count = count
        str = String(wrappedValue.prefix(count))

    }
}


@propertyWrapper
public struct UserDfaultsWrapper<T> {
    
    var key: String
    var defaultValue:T
    
    public var wrappedValue: T {
        get{

            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        nonmutating set{
            
            UserDefaults.standard.set(newValue, forKey: key)
            
        }
    }
    
    public init(_ key: String, defaultV: T) {
        self.key = key
        self.defaultValue = defaultV
        
    }
 
    
}


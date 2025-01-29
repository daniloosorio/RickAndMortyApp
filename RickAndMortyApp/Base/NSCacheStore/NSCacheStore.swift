//
//  NSCacheStore.swift
//  RickAndMortyApp
//
//  Created by Danilo Osorio on 28/01/25.
//

import Foundation

protocol NSCacheStoreDatasource {
    associatedtype Key: Hashable
    associatedtype Value
    
    func save(_ value: Value, forKey key: Key)
    func retrieve(forKey key: Key) -> Value?
    func removeValue(forKey key: Key)
    subscript(key:Key)-> Value? {get set}
    
}

class DefaultNSCacheStoreDatasource <Key: Hashable, value>: NSCacheStoreDatasource {
    private let wrapped = NSCache<WrappedKey, Entry>()
    
    func save(_ value: value, forKey key: Key) {
        let entry = Entry(value: value)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    func retrieve(forKey key: Key) -> Value? {
        let entry = wrapped.object(forKey: WrappedKey(key))
        return entry?.value
    }
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
    subscript(key: Key) -> value? {
        get {
            return retrieve(forKey: key)
        }
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }
            save(value, forKey: key)
        }
    }
    
    
}

private extension DefaultNSCacheStoreDatasource {
    final class WrappedKey: NSObject {
        let key: Key
        
        init(_ key: Key) {
            self.key = key
        }
        
        override var hash: Int {
            return key.hashValue
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let other = object as? WrappedKey else { return false }
            return other.key == key
        }
    }
}

private extension DefaultNSCacheStoreDatasource{
    final class Entry {
        let value: Value
        
        init(value: Value) {
            self.value = value
        }
    }
}

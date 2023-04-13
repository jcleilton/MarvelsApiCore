//
//  Constants.swift
//  
//
//  Created by Cleilton on 13/04/23.
//

import Foundation

@available(iOS 13.0, *)
struct Constants {
    
    static private var publicKey: String {
        "124e0927e82cf1c2919b72eeda4c55e0"
    }
    
    static private var privateKey: String {
        "a1b10ff8ace7e6bcaf20b9d37ca2dc3eaa2fbf13"
    }
    
    static private var routerURL: String {
        "https://gateway.marvel.com/v1/public/characters"
    }
    
    static private func getQuery(from value: String) -> String {
        return value == "" ? "" : "&nameStartsWith=\(value.replacingOccurrences(of: " ", with: "%20"))"
    }
    
    static private func getTS(_ time: Date) -> String {
        return String(time.timeIntervalSince1970)
    }
    
    static private func getHash(_ ts: String) -> String {
        return (ts + privateKey + publicKey).md5.lowercased()
    }
    
    static func url(offset: Int = -1, with value: String) -> String {
        let offSetString = offset == -1 ? "" : "&offset=\(offset)"
        let tsTime = Date()
        let ts = getTS(tsTime)
        let hash = getHash(ts)
        let nameStartsWith = getQuery(from: value)
        return routerURL + "?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)\(offSetString)&limit=10\(nameStartsWith)"
    }
    
}

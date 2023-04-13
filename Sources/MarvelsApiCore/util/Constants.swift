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
        Bundle.main.infoDictionary?["publicKey"] as? String ?? String()
    }
    
    static private var privateKey: String {
        Bundle.main.infoDictionary?["privateKey"] as? String ?? String()
    }
    
    static private var routerURL: String {
        Bundle.main.infoDictionary?["routerURL"] as? String ?? String()
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

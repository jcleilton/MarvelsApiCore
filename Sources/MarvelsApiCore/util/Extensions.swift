//
//  Extensions.swift
//  
//
//  Created by Cleilton on 13/04/23.
//

import CryptoKit
import Foundation

extension String {
    
    @available(iOS 13.0, *)
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8) ?? Data())
        
        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}


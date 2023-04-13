//
//  Thumbnail.swift
//  
//
//  Created by Cleilton on 13/04/23.
//

import Foundation

public struct Thumbnail: Codable {
    public let path: String
    public let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
    public func getFullPath() -> String {
        return self.path + "." + self.thumbnailExtension.rawValue
    }
}

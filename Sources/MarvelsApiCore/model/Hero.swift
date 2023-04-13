//
//  Hero.swift
//  
//
//  Created by Cleilton on 13/04/23.
//

import UIKit

@available(iOS 13.0, *)
public struct Hero: Identifiable, Decodable {
    public let description: String?
    public var id: Int = 0
    public let modified: String?
    public let name: String?
    public let resourceURI: String?
    public let thumbnail: Thumbnail?
    
    public func getImage(imageCashing: ImageCashingProtocol = ImageCashing(), completion: @escaping((UIImage?) -> Void)) {
        if let image = imageCashing.get(forKey: self.thumbnail?.getFullPath() ?? String()) {
            completion(image)
        } else {
            do {
                try imageCashing.save(self.thumbnail?.getFullPath() ?? String(), completion: { image in
                    completion(image)
                })
            } catch {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}

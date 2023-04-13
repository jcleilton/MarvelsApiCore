//
//  ImageCashing.swift
//  
//
//  Created by Cleilton on 13/04/23.
//

import UIKit

public protocol ImageCashingProtocol: AnyObject {
    func save(_ imageURL: String, completion: @escaping(UIImage?) -> Void) throws
    func get(forKey: String) -> UIImage?
}

@available(iOS 13.0, *)
public class ImageCashing: ImageCashingProtocol {
    
    private let manager: RequestManagerProtocol
    
    init(manager: RequestManagerProtocol) {
        self.manager = manager
    }
    
    public convenience init() {
        self.init(manager: RequestManager())
    }
    
    public func save(_ imageURL: String, completion: @escaping(UIImage?) -> Void) throws {
        
        guard let url = URL(string: imageURL) else {
            throw ConnectionSessionError.invalidUrl
        }
        
        manager.downloadImage(from: url) { (image) in
            guard let image = image else {
                completion(nil)
                return
            }
            let data = image.jpegData(compressionQuality: 1.0)
            UserDefaults.standard.set(data, forKey: imageURL)
            UserDefaults.standard.synchronize()
            completion(image)
        }
        
    }
    
    public func get(forKey: String) -> UIImage? {
        let data = UserDefaults.standard.object(forKey: forKey) as? Data
        if let dataImage = data {
            let img = UIImage(data: dataImage)
            return img
        }
        
        return nil
    }
    
}

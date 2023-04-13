//
//  RequestManagerProtocol.swift
//  
//
//  Created by Cleilton on 13/04/23.
//

import UIKit

@available(iOS 13.0, *)
protocol RequestManagerProtocol: AnyObject {
    
    func fecthData(with value: String, callback: @escaping (Result<[Hero], ErrorKind>) -> Void)
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
    
}

@available(iOS 13.0, *)
public class RequestManager: RequestManagerProtocol {
    private let manager: ConnectionSessionManagerProtocol
    
    init(manager: ConnectionSessionManagerProtocol) {
        self.manager = manager
    }
    
    public convenience init() {
        self.init(manager: ConnectionSessionManager())
    }
    
    public func fecthData(
        with value: String = "",
        callback: @escaping (Result<[Hero], ErrorKind>) -> Void
    ) {
        manager.invokeGetData(url: Constants.url(with: value)) { result in
            switch result {
            case .success(let data):
                do {
                    let marvelResponse = try JSONDecoder().decode(MarvelResponse.self, from: data)
                    callback(.success(marvelResponse.data.results))
                } catch {
                    return callback(.failure(ErrorKind.invalidJSON))
                }
            case .failure(let error):
                return callback(.failure(error))
            }
        }
    }
    
    public func downloadImage(
        from url: URL,
        completion: @escaping (UIImage?) -> Void
    ) {
        manager.downloadImage(from: url) { (image, err) in
            guard let image = image else {
                return completion(nil)
            }
            completion(image)
        }
    }
}

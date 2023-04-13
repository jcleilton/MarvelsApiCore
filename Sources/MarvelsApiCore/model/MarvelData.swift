//
//  MarvelData.swift
//  
//
//  Created by Cleilton on 13/04/23.
//

import Foundation

@available(iOS 13.0, *)
struct MarvelData: Decodable {
    var offset: Int = 0
    var limit: Int = 10
    var total: Int = 0
    var results: [Hero] = []
}

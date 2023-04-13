//
//  MarvelResponse.swift
//  
//
//  Created by Cleilton on 13/04/23.
//

import Foundation

@available(iOS 13.0, *)
struct MarvelResponse: Decodable {
    var code: Int = -1
    var status: String = String()
    var data: MarvelData
}

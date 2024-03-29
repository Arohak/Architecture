//
//  ProductsDTO.swift
//  interview
//
//  Created by Ara Hakobyan on 3/27/24.
//

import Foundation


struct ProductsDTO: Decodable {
    let products: [Product]
}

struct Product: Decodable {
    let id: Int
    let title: String
    let price: Int
    let brand: String
    let thumbnail: String
    let images: [String]
}

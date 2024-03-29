//
//  ProductsClient.swift
//  interview
//
//  Created by Ara Hakobyan on 3/27/24.
//

import Foundation

public struct ProductsClient {
    var fetchProducts: () async throws -> [Product]
    var fetchProduct: (Int) async throws -> Product
}

extension ProductsClient {
    static let liveValue = Self(
        fetchProducts: {
            let url = URL(string: "https://dummyjson.com/products")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(ProductsDTO.self, from: data)
            let products = Array(result.products.prefix(20))
            return products
        },
        fetchProduct: { id in
            let url = URL(string: "https://dummyjson.com/product/\(id)")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(Product.self, from: data)
            return result
        }
    )
    
    static let mockValue = Self (
        fetchProducts: {
            return [product, product, product]
        },
        fetchProduct: { _ in
            return product
        }
    )
    
    static let product = Product(id: 1, title: "title", price: 200, brand: "brand", thumbnail: "thumbnail", images: [])
}

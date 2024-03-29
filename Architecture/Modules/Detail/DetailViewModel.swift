//
//  DetailViewModel_.swift
//  CodeHub
//
//  Created by Ara Hakobyan on 27.06.21.
//

import Foundation

protocol DetailViewModel {
    func fetchProduct() async throws -> Product
}

final class DetailViewModelImpl {
    private let coordinator: DetailCoordinator
    private let client: ProductsClient
    private let id: Int
    
    init(coordinator: DetailCoordinator, client: ProductsClient, id: Int) {
        self.coordinator = coordinator
        self.client = client
        self.id = id
    }
}

extension DetailViewModelImpl: DetailViewModel {
    func fetchProduct() async throws -> Product {
        let product = try await client.fetchProduct(id)
        return product
    }
}

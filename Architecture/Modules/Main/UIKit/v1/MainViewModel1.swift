//
//  MainViewModel_1.swift
//  interview
//
//  Created by Ara Hakobyan on 3/28/24.
//

import Foundation

import Foundation
import Combine

protocol MainViewModelDelegate: AnyObject {
    func update(items: [CellModel])
}

final class MainViewModelImpl {
    weak var delegate: MainViewModelDelegate?
    private var coordinator: MainCoordinator
    private var client: ProductsClient
    
    public var products: [Product] = []
    
    init(coordinator: MainCoordinator, client: ProductsClient) {
        self.coordinator = coordinator
        self.client = client
    }
}

extension MainViewModelImpl {
    func fetchProducts() {
        Task { @MainActor in
            products = try await client.fetchProducts()
            let items = products.map { CellModel(image: nil, title: $0.title, desc: "$\($0.price)") }
            delegate?.update(items: items)
        }
    }
    
    func didSelect(product: Product) {
        coordinator.pushToDetail(product.id)
    }
    
    var didScroll: () async throws -> [Product] {
        {
            try await self.client.fetchProducts()
        }
    }
}

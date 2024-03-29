//
//  MainViewModel.swift
//  interview
//
//  Created by Ara Hakobyan on 3/27/24.
//

import Foundation
import Combine

struct MainEvent {
    enum VC {
        case viewDidLoad
        case didSelect(index: Int)
        case calculate(tip: Double)
        case loadMore
    }
    
    enum VM {
        case updateUI([CellModel])
        case updateCalculation(Double?)
    }
}


@MainActor
final class MainViewModel {
    private var disposables = Set<AnyCancellable>()
    
    private var coordinator: MainCoordinator
    private var client: ProductsClient
    
    @Published var output: MainEvent.VM?
    @Published var input: MainEvent.VC?
    
    private var products: [Product] = []
    private var selectedProduct: Product?
    
    public var productsCount: Int { products.count }

    public init(coordinator: MainCoordinator, client: ProductsClient) {
        self.coordinator = coordinator
        self.client = client
        bind()
    }
}

extension MainViewModel {
    private func bind() {
        $input
            .sink { [weak self] event in
                guard let event else { return }
                
                switch event {
                case .viewDidLoad:
                    self?.fetchProducts()
                case let .didSelect(index):
                    self?.didSelect(index: index)
                case let .calculate(tip):
                    self?.calculate(tip: tip)
                case .loadMore:
                    break
                }
            }
            .store(in: &disposables)
    }
    
    private func fetchProducts() {        
        Task {
            products = try await client.fetchProducts()
            let items = products.map { CellModel(image: nil, title: $0.title, desc: "$\($0.price)") }
            output = .updateUI(items)
        }
    }
    
    private func didSelect(index: Int) {
        guard let product = products[safe: index] else { return }
        selectedProduct = product
        coordinator.pushToDetail(product.id)
    }
    
    private func calculate(tip: Double) {
        guard let price = selectedProduct?.price, price >= 0, tip >= 0 else {
            output = .updateCalculation(nil)
            return
        }
        
        let result = Double(price) / 100  * tip
        output = .updateCalculation(result)
    }
}

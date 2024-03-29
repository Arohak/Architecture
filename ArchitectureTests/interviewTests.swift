//
//  interviewTests.swift
//  interviewTests
//
//  Created by Ara Hakobyan on 3/27/24.
//

import XCTest
@testable import Architecture

final class interviewTests: XCTestCase {
    var sut: MainViewModel1!
    
    override func setUp() {
        sut = MockMainViewModel()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testProductsFetchCount() async throws {
        let products = try await sut.fetchProducts()
        
        XCTAssertEqual(products.count, 3)

//        XCTAssertEqual(vm.count, 1)
    }
}

class MockMainViewModel: MainViewModel1 {
    private var client: ProductsClient = .mockValue
    public var selectedProduct: Product?

    func fetchProducts() async throws -> [Product] {
        try await client.fetchProducts()
    }
    
    func didSelect(product: Product) {
        selectedProduct = product
    }
}

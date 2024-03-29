//
//  MainFeatureTests.swift
//  interviewTests
//
//  Created by Ara Hakobyan on 3/28/24.
//

import Foundation
import Combine
import XCTest
@testable import interview

final class MainFeatureTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    let mockCoordinator = MockCoordinator()
    let mocClient: ProductsClient = .mockValue
//    var sut: MainViewModel!
    
//    @MainActor 
//    override func setUp() {
//        sut = MainViewModel(coordinator: mockCoordinator, client: mocClient)
//        sut.input = input
//        super.setUp()
//    }
//    
//    override func tearDown() {
//        super.tearDown()
//        sut = nil
//    }
    
    @MainActor
    func testFetchProducts() {
        // Given
        let sut = MainViewModel(coordinator: mockCoordinator, client: mocClient)
        
        // When
        sut.input = .viewDidLoad
        _ = XCTWaiter.wait(for: [expectation(description: "Wait a bit")], timeout: 0.2)

        // Then
        XCTAssertEqual(sut.productsCount, 3)
        
    }
    
    @MainActor
    func testCalculationPriceSuccess() {
        // Given
        let product = ProductsClient.product
        let sut = MainViewModel(coordinator: mockCoordinator, client: mocClient)
        
        // When
        sut.input = .didSelect(product: product)
        sut.input = .calculate(tip: 10)

        // Then
        sut.$output
            .sink { event in
                if case let .updateCalculation(value) = event {
                    XCTAssertEqual(value, 20)
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func testCalculationPriceFailer() {
        // Given
        let product = ProductsClient.product
        let sut = MainViewModel(coordinator: mockCoordinator, client: mocClient)
        
        // When
        sut.input = .didSelect(product: product)
        sut.input = .calculate(tip: -10)

        // Then
        sut.$output
            .sink { event in
                if case let .updateCalculation(value) = event {
                    XCTAssertNil(value)
                }
            }
            .store(in: &cancellables)
    }
}

class MockCoordinator: MainCoordinator {
    var childs: [interview.Coordinator] = []
    
    func start() { }
    func pushToDetail(_ id: Int) { }
}


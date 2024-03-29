//
//  BaseViewModel.swift
//  
//
//  Created by Ara Hakobyan on 3/27/24.
//

import Foundation
import Combine

public protocol ViewModel {
    var client: ProductsClient { get set }
}

open class BaseViewModel: ViewModel {
    public var client: ProductsClient
    
    init(client: ProductsClient) {
        self.client = client
    }

    deinit {
        print("Deinit: \(String(describing: self))")
    }
}

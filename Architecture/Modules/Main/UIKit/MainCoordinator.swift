//
//  MainCoordinator.swift
//  CodeHub
//
//  Created by Ara Hakobyan on 04.07.21.
//

import UIKit

protocol Coordinator {
    var childs: [Coordinator] { get set }
    
    func start()
}

protocol MainCoordinator: Coordinator {
    func pushToDetail(_ id: Int)
}

class MainCoordinatorImpl: MainCoordinator {
    var childs: [Coordinator] = []
    
    private var window: UIWindow
    private var navigationViewController: UINavigationController!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    @MainActor func start() {
//        let viewModel = MainViewModelImpl(coordinator: self, client: .liveValue)
//        let viewController = MainViewController1(viewModel: viewModel)
//        
        let viewModel = MainViewModel(coordinator: self, client: .liveValue)
        let viewController = MainViewController(viewModel: viewModel)
        
        navigationViewController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
    }
    
    func pushToDetail(_ id: Int) {
        let detailCoordinator = DetailCoordinator(navigationViewController: navigationViewController, id: id)
        childs.append(detailCoordinator)
        detailCoordinator.start()
    }
}

//
//  DetailCoordinator.swift
//  CodeHub
//
//  Created by Ara Hakobyan on 04.07.21.
//

import UIKit

final class DetailCoordinator: Coordinator {
    var childs: [Coordinator] = []
    
    private var navigationViewController: UINavigationController
    private var id: Int

    init(navigationViewController: UINavigationController, id: Int) {
        self.navigationViewController = navigationViewController
        self.id = id
    }
    
    func start() {
        let viewModel = DetailViewModelImpl(coordinator: self, client: .liveValue, id: id)
        let viewController = DetailViewController(viewModel: viewModel)
        navigationViewController.pushViewController(viewController, animated: true)
    }
}

//
//  ViewController.swift
//  interview
//
//  Created by Ara Hakobyan on 3/27/24.
//

import UIKit

final class MainViewController1: UIViewController {
    private let viewModel: MainViewModelImpl
    private let rootView = TableView()
        
    init(viewModel: MainViewModelImpl) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        viewModel.fetchProducts()
    }
}

extension MainViewController1: MainViewModelDelegate {
    func update(items: [CellModel]) {
        rootView.update(with: items)
    }
}


//
//  DetailViewController_.swift
//  CodeHub
//
//  Created by Ara Hakobyan on 27.06.21.
//

import UIKit

class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel
    private let mainView = DetailView()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = mainView
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProduct()
    }
    
    private func fetchProduct() {
        Task {
            let product = try await viewModel.fetchProduct()
            mainView.update(with: .init(title: product.title, desc: product.brand))
        }
    }
}

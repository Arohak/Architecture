//
//  MainViewController.swift
//  interview
//
//  Created by Ara Hakobyan on 3/28/24.
//

import Foundation
import UIKit
import Combine

final class MainViewController: UIViewController {
    private var disposables = Set<AnyCancellable>()

    private let viewModel: MainViewModel
    private let rootView = TableView()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
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
        bind()
        viewModel.input = .viewDidLoad
    }
}

extension MainViewController {
    private func bind() {
        viewModel.$output
            .sink { [weak self] event in
                guard let event else { return }

                switch event {
                case let .updateUI(items):
                    self?.rootView.update(with: items)
                    self?.viewActions()
                case let .updateCalculation(value):
                    break
                }
            }
            .store(in: &disposables)
    }
    
    private func viewActions() {
        rootView.event = { [weak self] type in
            switch type {
            case let .didSelect(index):
                self?.viewModel.input = .didSelect(index: index)
            case .loadMore:
                self?.viewModel.input = .loadMore
            }
        }
    }
}

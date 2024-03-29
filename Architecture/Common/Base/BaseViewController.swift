//
//  BaseViewController.swift
//  
//
//  Created by Ara Hakobyan on 3/27/24.
//

import UIKit
import Combine

open class BaseViewController<VM: ViewModel>: UIViewController {
    var vm: VM
    var disposables = Set<AnyCancellable>()

    init(vm: VM) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("Deinit: \(String(describing: self))")
    }
}

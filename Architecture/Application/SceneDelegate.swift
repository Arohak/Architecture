//
//  SceneDelegate.swift
//  interview
//
//  Created by Ara Hakobyan on 3/27/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let coordinator = MainCoordinatorImpl(window: window)
        coordinator.start()
        self.window = window

//        window?.rootViewController = MainDependencyProvider.root
//        window?.makeKeyAndVisible()
    }

}


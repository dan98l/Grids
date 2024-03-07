//
//  SceneDelegate.swift
//  Numbers
//
//  Created by Daniil MacBook Pro on 06.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        let verticalListCollection = VerticalListCollection()
        verticalListCollection.setupVerticalListCollection(
            viewModel: VerticalListCollectionViewModel(size: window.frame.size)
        )
        
        window.rootViewController = verticalListCollection
        window.makeKeyAndVisible()
        self.window = window
    }
}

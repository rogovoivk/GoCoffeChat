//
//  SceneDelegate.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 19.07.2022.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let rootWireframe = RootWireframe()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
//        FirebaseApp.configure()
        let window  = UIWindow(windowScene: scene)
//        let rootViewController = TBViewController()
//        window.rootViewController = rootViewController
//        window.makeKeyAndVisible()
        
//        let window = UIWindow(windowScene: windowScene)
        self.rootWireframe.application(window: window)
        self.window = window
//        if let windowScene = scene as? UIWindowScene {
//                let window = UIWindow(windowScene: windowScene)
//                self.rootWireframe.application(window: self.window)
//            }
    }


}


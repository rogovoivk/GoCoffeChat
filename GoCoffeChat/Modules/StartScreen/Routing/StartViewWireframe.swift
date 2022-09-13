//
//  StartViewWireframe.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 25.08.2022.
//

import UIKit

class StartViewWireframe: NSObject, StartViewWireframeProtocol {
    

    static var instance: StartViewWireframe?

    static func getInstance() -> StartViewWireframe {
        if (instance == nil) {
            instance = StartViewWireframe()
        }
        return instance!
    }

    private override init() {}

    
    var startScreenViewController: StartViewController?
    var window: UIWindow?
    
    func presentStartViewControllerInWindow() {
        let vc = StartViewController()
        vc.modalPresentationStyle = .fullScreen
        self.startScreenViewController = vc
        
        self.window?.rootViewController = startScreenViewController
        self.window?.makeKeyAndVisible()
//        present(vc, animated: true, completion: nil)
    }
    
    func presentSignInViewController() {
        
    }
    
    func presentSignUnViewController() {
        
    }
    

}

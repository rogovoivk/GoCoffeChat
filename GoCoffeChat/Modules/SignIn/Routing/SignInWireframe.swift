//
//  SignInWirefrme.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 25.08.2022.
//

import UIKit

class SignInWireframe: NSObject, SignInWireframeProtocol {

    static var instance: SignInWireframe?

    static func getInstance() -> SignInWireframe {
        if (instance == nil) {
            instance = SignInWireframe()
        }
        return instance!
    }

    private override init() {}

    
    var signInScreenViewController: SignInViewController?
    var window: UIWindow?
    
    func presentSignInViewControllerInWindow() {
        let vc = SignInViewController()
//        vc.modalPresentationStyle = .fullScreen
        self.signInScreenViewController = vc
        var nav1 = UINavigationController()
        nav1.viewControllers = [vc]
        self.window?.rootViewController = nav1
        self.window?.makeKeyAndVisible()
//        present(vc, animated: true, completion: nil)
    }
    
    func presentSignUnViewController() {
        let vc = SignUpViewController()
        vc.navigation = SignUpWireframe()
        vc.interactor = SignUpInteractor()
//        vc.modalPresentationStyle = .fullScreen
//        self.signInScreenViewController?.present(vc, animated: true, completion: nil)
        signInScreenViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

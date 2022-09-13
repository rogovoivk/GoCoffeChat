//
//  SignUpWireframe.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 25.08.2022.
//

import UIKit

class SignUpWireframe: NSObject, SignUpWireframeProtocol {
    
    var signUpViewController: SignInViewController?
    
    func dismissSignUpViewController() {
        self.signUpViewController?.dismiss(animated: true)
    }
    
    func presentTabBarScreen() {
       
    }
    
}

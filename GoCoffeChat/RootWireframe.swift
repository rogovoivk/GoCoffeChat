//
//  RootWireframe.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 25.08.2022.
//

import UIKit
import Firebase

class RootWireframe: NSObject {

    let SignInScreenWireframe: SignInWireframe?
    let TBScreenWireframe: TabBarViewWireframe?
    
    override init() {
        self.SignInScreenWireframe = SignInWireframe.getInstance()
        self.TBScreenWireframe = TabBarViewWireframe.getInstance()
    }
    
    func application(window: UIWindow?) -> Bool {
        FirebaseApp.configure()
//        self.checkPersistedUser()
        
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if user == nil {
                self.SignInScreenWireframe?.window = window
                self.SignInScreenWireframe?.presentSignInViewControllerInWindow()
            } else {
                print("user is auth")
                self.TBScreenWireframe?.window = window
                self.TBScreenWireframe?.presentTabBarViewControllerInWindow()
            }
        }
                
        return true
    }
    
}

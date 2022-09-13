//
//  SignInViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 20.07.2022.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    var navigation: SignInWireframe = SignInWireframe.getInstance()
    var signInView = SignInView()
    
    @objc func pressedSignInButton() {
        print("pressed button GO")
        let email = signInView.emailTextField.text!
        let password = signInView.passwordTextField.text!

        if (!email.isEmpty && !password.isEmpty){
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil{
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    self.showError(error: error as! AuthErrorCode)
                }
            }
        } else {
            showAllert()
        }
        
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "MenuTabBarID")
//        vc!.modalPresentationStyle = .fullScreen
//        self.present(vc!, animated: true, completion: nil)
    }
    
    func showError(error: AuthErrorCode){
        let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showAllert(){
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func pressedSignUnButton() {
        print("press Register")
        navigation.presentSignUnViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInView.screenView = self.view
        signInView.signInViewController = self
        signInView.setView()

    }
    
        override func viewDidAppear(_ animated: Bool) {
            Auth.auth().addStateDidChangeListener{(auth, user) in
                if user != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }

 

}



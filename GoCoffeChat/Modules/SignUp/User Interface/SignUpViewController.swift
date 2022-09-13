//
//  SignUpViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 19.07.2022.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, SignUpViewControllerProtocol {
    
//    var navigation: SignUpWireframe?
    
    var navigation: SignUpWireframe?
    var interactor: SignUpInteractor?
    var signUpView = SignUpView()

    
    @objc func pressedButton() {
        print("pressed button GO")
        
        let email = signUpView.emailTextField.text!
        let nickname = signUpView.nikenameTextField.text!
        let password1 = signUpView.passwordTextField.text!
        let password2 = signUpView.secondPasswordTextField.text!
        let gender = signUpView.genderItems[signUpView.genderSC.selectedSegmentIndex]
        var error: Error?
        
        if (!email.isEmpty && !nickname.isEmpty && !password1.isEmpty && !password2.isEmpty && (password1 == password2)){
            error = self.interactor?.createUser(email: email, nickname: nickname, password1: password1, gender: gender)
        } else {
            showAllert()
        }
        
        if (error != nil){
            showError(error: error)
            return
        }
        
        navigation?.presentTabBarScreen()
        print("Вроде работает")

    }
    
    func showError(error: Error?){
        let alert = UIAlertController(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAllert(){
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUpView.screenView = self.view
        signUpView.signUpViewController = self
        signUpView.setView()
    }


 

}


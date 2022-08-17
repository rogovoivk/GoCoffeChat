//
//  SignInViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 20.07.2022.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    
    private let screenContentHeigh = 600
    private var scrollView = UIScrollView()
    private var myView = UIView()

//    welcomeScreen
    private var bgImage = UIImageView(image: UIImage(named: "backScreen"))
    
    private var emailTextField = UITextField()
    private var passwordTextField = UITextField()
    
    private let signInLablel: UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .center
        myLabel.text = "Добро пожаловать :)"
        myLabel.font = UIFont(name: "systemFont", size: 36)
//        myLabel.numberOfLines = 0
//        myLabel.lineBreakMode = .byWordWrapping
        myLabel.translatesAutoresizingMaskIntoConstraints = false
//        myLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        myLabel.textColor = .white
        return myLabel
    }()
    
    private let signInButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle("Войти", for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.backgroundColor =
        UIColor(red: 0.69, green: 0.208, blue: 0.169, alpha: 1)
        myButton.addTarget(self, action: #selector(pressedSignInButton), for: .touchUpInside)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.layer.cornerRadius = 10
        return myButton
    }()
    
    @objc func pressedSignInButton() {
        print("pressed button GO")
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
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
    
    private let signUnButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle("Зарегестрироваться", for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.backgroundColor = .none
        myButton.addTarget(self, action: #selector(pressedSignUnButton), for: .touchUpInside)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.layer.cornerRadius = 10
        return myButton
    }()
    
    @objc func pressedSignUnButton() {
        print("press Register")
//        let vc = storyboard?.instantiateViewController(withIdentifier: "SignUpID") as! SignUpViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
//        self.present(vc, animated: true, completion: nil)
        
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Войти"
        addSubviews()
        layoutViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if user != nil {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func addSubviews() {
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgImage)
        let bgBlur = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: bgBlur)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurEffectView)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        view.addSubview(scrollView)
        
        myView = UIView(frame: CGRect(x: 0, y: 0, width: Int(view.frame.size.width), height: screenContentHeigh))
        
        scrollView.addSubview(myView)
        
        emailTextField = genTextField(myPlaceholder: "email")
        passwordTextField = genTextField(myPlaceholder: "Пароль")
        
        myView.addSubview(signInLablel)
        myView.addSubview(emailTextField)
        myView.addSubview(passwordTextField)
        myView.addSubview(signInButton)
        myView.addSubview(signUnButton)
        
        scrollView.contentSize = CGSize(width: Int(view.frame.size.width), height: screenContentHeigh)
    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            bgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                        
            signInLablel.topAnchor.constraint(equalTo: myView.topAnchor, constant: 125),
            signInLablel.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            signInLablel.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
//            sighUpLablel.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: signInLablel.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            signInButton.topAnchor.constraint(equalTo: passwordTextField.layoutMarginsGuide.bottomAnchor, constant: 35),
//            goButton.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 32),
//            goButton.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -32),
            signInButton.widthAnchor.constraint(equalToConstant: 311),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            signUnButton.topAnchor.constraint(equalTo: signInButton.layoutMarginsGuide.bottomAnchor, constant: 16),
            signUnButton.widthAnchor.constraint(equalToConstant: 311),
            signUnButton.heightAnchor.constraint(equalToConstant: 50),
            signUnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
            
        ])
    }
    
    func genTextField(myPlaceholder: String) -> UITextField{
        let myTextField =  UITextField()
        myTextField.font = UIFont.systemFont(ofSize: 17)
        myTextField.borderStyle = UITextField.BorderStyle.roundedRect
        myTextField.autocorrectionType = UITextAutocorrectionType.no
//        myTextField.keyboardType = UIKeyboardType.default
//        myTextField.returnKeyType = UIReturnKeyType.done
//        myTextField.clearButtonMode = UITextField.ViewMode.whileEditing
//        myTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        myTextField.placeholder = myPlaceholder
        myTextField.backgroundColor = .white
//        myTextField.backgroundColor = UIColor(red: 0.471, green: 0.471, blue: 0.502, alpha: 0.16)
        return myTextField
    }

 

}



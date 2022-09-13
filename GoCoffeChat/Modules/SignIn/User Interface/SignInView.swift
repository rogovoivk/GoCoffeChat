//
//  SignInView.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 08.09.2022.
//

import UIKit

class SignInView: UIView {
    
    var screenView: UIView?
    var signInViewController: SignInViewController?

    private let screenContentHeigh = 600
    private var scrollView = UIScrollView()
    private var myView = UIView()

    private var bgImage = UIImageView(image: UIImage(named: "backScreen"))
    
    public var emailTextField = UITextField()
    public var passwordTextField = UITextField()
    
    private let signInLablel: UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .center
        myLabel.text = "Добро пожаловать :)"
        myLabel.font = UIFont(name: "systemFont", size: 36)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
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
    
    @objc func pressedSignInButton(){
        signInViewController?.pressedSignInButton()
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
    
    @objc func pressedSignUnButton(){
        signInViewController?.pressedSignUnButton()
    }
    
    func addSubviews() {
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        screenView?.addSubview(bgImage)
        let bgBlur = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: bgBlur)
        blurEffectView.frame = screenView!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        screenView?.addSubview(blurEffectView)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenView!.frame.size.width, height: screenView!.frame.size.height))
        screenView?.addSubview(scrollView)
        
        myView = UIView(frame: CGRect(x: 0, y: 0, width: Int(screenView!.frame.size.width), height: screenContentHeigh))
        
        scrollView.addSubview(myView)
        
        emailTextField = genTextField(myPlaceholder: "email")
        passwordTextField = genTextField(myPlaceholder: "Пароль")
        
        myView.addSubview(signInLablel)
        myView.addSubview(emailTextField)
        myView.addSubview(passwordTextField)
        myView.addSubview(signInButton)
        myView.addSubview(signUnButton)
        
        scrollView.contentSize = CGSize(width: Int(screenView!.frame.size.width), height: screenContentHeigh)
    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: screenView!.topAnchor, constant: 0),
            bgImage.leadingAnchor.constraint(equalTo: screenView!.leadingAnchor, constant: 0),
            bgImage.trailingAnchor.constraint(equalTo: screenView!.trailingAnchor, constant: 0),
            bgImage.bottomAnchor.constraint(equalTo: screenView!.bottomAnchor, constant: 0),
                        
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
            signInButton.centerXAnchor.constraint(equalTo: screenView!.centerXAnchor, constant: 0),
            
            signUnButton.topAnchor.constraint(equalTo: signInButton.layoutMarginsGuide.bottomAnchor, constant: 16),
            signUnButton.widthAnchor.constraint(equalToConstant: 311),
            signUnButton.heightAnchor.constraint(equalToConstant: 50),
            signUnButton.centerXAnchor.constraint(equalTo: screenView!.centerXAnchor, constant: 0)
            
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
    
    func setView(){
        addSubviews()
        layoutViews()
    }

}

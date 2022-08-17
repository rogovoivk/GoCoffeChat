//
//  SignUpViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 19.07.2022.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    
    private let screenContentHeigh = 600
    private var scrollView = UIScrollView()
    private var myView = UIView()

//    @IBOutlet weak var scrollView: UIScrollView!
    private var bgImage = UIImageView(image: UIImage(named: "backScreen"))
    
    private var emailTextField = UITextField()
    private var nikenameTextField = UITextField()
    private var passwordTextField = UITextField()
    private var secondPasswordTextField = UITextField()
    private var genderTextView = UITextField()
    
    private let sighUpLablel: UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .center
        myLabel.text = "Регистрация"
        myLabel.font = UIFont(name: "systemFont", size: 36)
//        myLabel.numberOfLines = 0
//        myLabel.lineBreakMode = .byWordWrapping
        myLabel.translatesAutoresizingMaskIntoConstraints = false
//        myLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        myLabel.textColor = .white
        return myLabel
    }()
    
    let genderItems = ["man", "women"]
    private let genderSC: UISegmentedControl = {
        let genderItems = ["man", "women"]
        let genderSC = UISegmentedControl(items : genderItems)
        genderSC.selectedSegmentIndex = 0
        genderSC.layer.cornerRadius = 5.0
        genderSC.backgroundColor = UIColor(red: 0.471, green: 0.471, blue: 0.502, alpha: 0.16)
        genderSC.tintColor = UIColor.yellow
        genderSC.translatesAutoresizingMaskIntoConstraints = false
        return genderSC
    }()
    
    private let goButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle("Продолжить", for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.backgroundColor =
        UIColor(red: 0.69, green: 0.208, blue: 0.169, alpha: 1)
//        UIColor(red: 0, green: 0.478, blue: 1, alpha: 1)
        myButton.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.layer.cornerRadius = 10
        return myButton
    }()
    
    @objc func pressedButton() {
        print("pressed button GO")
        
        let email = emailTextField.text!
        let nickname = nikenameTextField.text!
        let password1 = passwordTextField.text!
        let password2 = secondPasswordTextField.text!
        let gender = genderItems[genderSC.selectedSegmentIndex]
        
        if (!email.isEmpty && !nickname.isEmpty && !password1.isEmpty && !password2.isEmpty && (password1 == password2)){
            Auth.auth().createUser(withEmail: email, password: password1) { result, error in
                if error == nil{
                    if let result = result{
                        print("тут результат (id зарегестрированного пользователья)")
                        print(result.user.uid)
                        let ref = Database.database().reference().child("users")
                        ref.child(result.user.uid).updateChildValues(["email": email, "nickname": nickname, "gender": gender])
                        
//                        let vc = StartViewController()
//                        vc.modalPresentationStyle = .fullScreen
//                        self.present(vc, animated: true, completion: nil)
                        self.dismiss(animated: true)
                    }
                }
                else {
                    let alert = UIAlertController(title: "Ошибка", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            showAllert()

        }
        print("Вроде работает")
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "MenuTabBarID")
//        vc!.modalPresentationStyle = .fullScreen
//        self.present(vc!, animated: true, completion: nil)
    }
    
    func showAllert(){
        let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private let myLabel: UILabel = {
        let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        myLabel.textAlignment = .center
        myLabel.text = "Нажимая на кнопку, вы соглашаетесь с политикой конфиденциальности и обработки персональных данных, а также принимаете пользовательское соглашение"
//        myLabel.font = UIFont(name: "systemFont", size: 15)
        myLabel.font = UIFont.systemFont(ofSize: 15.0)
        myLabel.numberOfLines = 0
        myLabel.lineBreakMode = .byWordWrapping
        myLabel.translatesAutoresizingMaskIntoConstraints = false
//        myLabel.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        myLabel.textColor = .white
        return myLabel
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Регистрация"
        addSubviews()
        layoutViews()
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
        
        emailTextField.textContentType = UITextContentType.emailAddress
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        passwordTextField.textContentType = UITextContentType.password
        secondPasswordTextField.textContentType = UITextContentType.password
        passwordTextField.isSecureTextEntry = false
        secondPasswordTextField.isSecureTextEntry = true
        
        passwordTextField.becomeFirstResponder()
        secondPasswordTextField.becomeFirstResponder()
        
        emailTextField = genTextField(myPlaceholder: "email")
        nikenameTextField = genTextField(myPlaceholder: "Имя или никнейм")
        passwordTextField = genTextField(myPlaceholder: "пароль")
        secondPasswordTextField = genTextField(myPlaceholder: "повторите пароль")
        genderTextView = genTextField(myPlaceholder: " ")
        genderTextView.text = "Пол"
        genderTextView.isUserInteractionEnabled = false
        genderTextView.backgroundColor = .none
        genderTextView.textColor = UIColor.white
        genderTextView.borderStyle = UITextField.BorderStyle.none
        
        myView.addSubview(sighUpLablel)
        myView.addSubview(emailTextField)
        myView.addSubview(nikenameTextField)
        myView.addSubview(passwordTextField)
        myView.addSubview(secondPasswordTextField)
        myView.addSubview(genderTextView)
        myView.addSubview(genderSC)
        myView.addSubview(goButton)
        myView.addSubview(myLabel)
        
        scrollView.contentSize = CGSize(width: Int(view.frame.size.width), height: screenContentHeigh)
    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            bgImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            bgImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            bgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                        
            sighUpLablel.topAnchor.constraint(equalTo: myView.topAnchor, constant: 125),
            sighUpLablel.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            sighUpLablel.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
//            sighUpLablel.heightAnchor.constraint(equalToConstant: 50),
            
            emailTextField.topAnchor.constraint(equalTo: sighUpLablel.bottomAnchor, constant: 50),
            emailTextField.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            nikenameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            nikenameTextField.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            nikenameTextField.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            nikenameTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: nikenameTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),

            secondPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            secondPasswordTextField.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            secondPasswordTextField.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            secondPasswordTextField.heightAnchor.constraint(equalToConstant: 50),

            genderTextView.topAnchor.constraint(equalTo: secondPasswordTextField.layoutMarginsGuide.bottomAnchor, constant: 35),
            genderSC.topAnchor.constraint(equalTo: genderTextView.topAnchor, constant: 0),
            genderTextView.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 31),
            genderSC.leadingAnchor.constraint(equalTo: genderTextView.trailingAnchor, constant: 150),
            genderSC.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -51),

            goButton.topAnchor.constraint(equalTo: genderTextView.layoutMarginsGuide.bottomAnchor, constant: 35),
//            goButton.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 32),
//            goButton.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -32),
            goButton.widthAnchor.constraint(equalToConstant: 311),
            goButton.heightAnchor.constraint(equalToConstant: 50),
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),

            myLabel.topAnchor.constraint(equalTo: goButton.layoutMarginsGuide.bottomAnchor, constant: 24),
            myLabel.leadingAnchor.constraint(equalTo: myView.leadingAnchor, constant: 16),
            myLabel.trailingAnchor.constraint(equalTo: myView.trailingAnchor, constant: -16),
            
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
        myTextField.returnKeyType = UIReturnKeyType.done
//        myTextField.backgroundColor = UIColor(red: 0.471, green: 0.471, blue: 0.502, alpha: 0.16)
        return myTextField
    }

 

}


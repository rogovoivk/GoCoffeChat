//
//  ViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 19.07.2022.
//

import UIKit
import Firebase

class StartViewController: UIViewController {
    
    private let screenContentHeigh = 600
    private var scrollView = UIScrollView()
    private var myView = UIView()

    private let welcomeLablel: UILabel = {
        let myLabel = UILabel()
        myLabel.textAlignment = .center
        myLabel.text = "Добро пожаловать :)"
        myLabel.font = UIFont(name: "systemFont", size: 36)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.textColor = .black
        return myLabel
    }()
    
    private let signOutButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle("Выйти", for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.backgroundColor =
        UIColor(red: 0.69, green: 0.208, blue: 0.169, alpha: 1)
        myButton.addTarget(self, action: #selector(pressedSignOutButton), for: .touchUpInside)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.layer.cornerRadius = 10
        return myButton
    }()
    
    @objc func pressedSignOutButton() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Start App")
        
        addSubviews()
        layoutViews()
        loadViewIfNeeded()
        
        FirebaseApp.configure()
        

        
//        self.ShowModalSignIn()
    }
    
//    override func loadViewIfNeeded() {
//        print("load SatrtView If Needed")
//
//        FirebaseApp.configure()
//        Auth.auth().addStateDidChangeListener{(auth, user) in
//            if user == nil {
//                self.ShowModalSignIn()
//            } else {
//                let vc = TBViewController()
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: true, completion: nil)
//            }
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("viewDidAppear started")
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if user == nil {
                self.ShowModalSignIn()
            } else {
                let vc = TBViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
        
        
    }
    
    func addSubviews() {
        view.addSubview(signOutButton)
        view.addSubview(welcomeLablel)
    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            welcomeLablel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            welcomeLablel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            welcomeLablel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            signOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            signOutButton.widthAnchor.constraint(equalToConstant: 70),
            signOutButton.heightAnchor.constraint(equalToConstant: 45)
                        
            
            
        ])
    }
    
    func ShowModalSignIn(){
//        let vc = storyboard?.instantiateViewController(withIdentifier: "SignInNavigationController")
//        vc!.modalPresentationStyle = .fullScreen
//        self.present(vc!, animated: true, completion: nil)
        
        let newChatController = SignInViewController()
        let vc = UINavigationController(rootViewController: newChatController)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }


}


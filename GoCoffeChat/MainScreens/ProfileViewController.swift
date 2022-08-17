//
//  SettingsViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 24.07.2022.
//

import UIKit
import Firebase
import SceneKit

class ProfileViewController: UIViewController {
    
    private var bgImage = UIImageView(image: UIImage(named: "backScreen"))
    private var nicknameTextView = UILabel()
    private var emaleTextView = UILabel()
    private var genderTextView = UILabel()
    
    private let imagePrifile: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let signOutButton: UIButton = {
        let myButton = UIButton(type: .system)
        myButton.setTitle("Выйти", for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.backgroundColor = . systemBlue
//        UIColor(red: 0.69, green: 0.208, blue: 0.169, alpha: 1)
        myButton.addTarget(self, action: #selector(pressedSignOutButton), for: .touchUpInside)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.layer.cornerRadius = 10
        return myButton
    }()
    
    
    @objc func pressedSignOutButton() {
        do {
            try Auth.auth().signOut()
//            let vc = StartViewController()
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
            self.dismiss(animated: true)
        } catch {
            print(error)
        }
    }
    
    private let signOutContainer: UIView = {
        let signOutContainer = UIView()
        signOutContainer.translatesAutoresizingMaskIntoConstraints = false
        
        return signOutContainer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchUserAndSetupProfileData()
        
        addSubviews()
        layoutViews()

    }
    
    func fetchUserAndSetupProfileData() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User(dictionary: dictionary)
                self.genProfileTextViews(textView: self.nicknameTextView, text1: "",text2: user.nickname!)
                self.genProfileTextViews(textView: self.emaleTextView, text1: "email: ",text2: user.email!)
                self.genProfileTextViews(textView: self.genderTextView, text1: "пол: ", text2: user.gender!)
            }
            
        }, withCancel: nil)
    }
    
    func addSubviews(){
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgImage)
        let bgBlur = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: bgBlur)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurEffectView)
        
        view.addSubview(imagePrifile)
        view.addSubview(signOutButton)
        view.addSubview(nicknameTextView)
        view.addSubview(emaleTextView)
        view.addSubview(genderTextView)
        view.addSubview(signOutContainer)

    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            imagePrifile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imagePrifile.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imagePrifile.heightAnchor.constraint(equalToConstant: 70),
            imagePrifile.widthAnchor.constraint(equalToConstant: 70),
            
            nicknameTextView.topAnchor.constraint(equalTo: imagePrifile.bottomAnchor, constant: 25),
            nicknameTextView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nicknameTextView.heightAnchor.constraint(equalToConstant: 25),
            nicknameTextView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            emaleTextView.topAnchor.constraint(equalTo: nicknameTextView.bottomAnchor, constant: 25),
            emaleTextView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emaleTextView.heightAnchor.constraint(equalToConstant: 25),
            emaleTextView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            genderTextView.topAnchor.constraint(equalTo: emaleTextView.bottomAnchor, constant: 25),
            genderTextView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            genderTextView.heightAnchor.constraint(equalToConstant: 25),
            genderTextView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            signOutContainer.topAnchor.constraint(equalTo: genderTextView.bottomAnchor, constant: 0),
            signOutContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            signOutContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            signOutContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            signOutButton.centerYAnchor.constraint(equalTo: signOutContainer.centerYAnchor),
            signOutButton.leadingAnchor.constraint(equalTo: signOutContainer.leadingAnchor, constant: 0),
            signOutButton.trailingAnchor.constraint(equalTo: signOutContainer.trailingAnchor, constant: 0),
            signOutButton.heightAnchor.constraint(equalToConstant: 50),

        ])
    }
    
    func genProfileTextViews(textView: UILabel, text1: String, text2: String){
        textView.textColor = .white
        textView.font = UIFont(name: "Times New Roman" , size: 22)
        textView.text = "\(text1)\(text2)"
        textView.textAlignment = .center
        textView.lineBreakMode = .byWordWrapping
        textView.translatesAutoresizingMaskIntoConstraints = false
        
    }

}

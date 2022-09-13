//
//  ProfileView.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 12.09.2022.
//

import UIKit

class ProfileView: UIView {
    
    var profileViewController: ProfileViewController?
    var screenView: UIView?

    public var bgImage = UIImageView(image: UIImage(named: "backScreen"))
    public var nicknameTextView = UILabel()
    public var emaleTextView = UILabel()
    public var genderTextView = UILabel()
    
    public let imagePrifile: UIImageView = {
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
        profileViewController?.pressedSignOutButton()
    }
    
    private let signOutContainer: UIView = {
        let signOutContainer = UIView()
        signOutContainer.translatesAutoresizingMaskIntoConstraints = false
        
        return signOutContainer
    }()

    func setView() {
        self.fetchUserAndSetupProfileData()
        
        addSubviews()
        layoutViews()

    }
    
    func fetchUserAndSetupProfileData() {
//        interactor?.fetchUserAndSetupProfileData()
        profileViewController?.fetchUserAndSetupProfileData()
    }
    
    func addSubviews(){
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        screenView!.addSubview(bgImage)
        let bgBlur = UIBlurEffect(style: UIBlurEffect.Style.systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: bgBlur)
        blurEffectView.frame = screenView!.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        screenView!.addSubview(blurEffectView)
        
        screenView!.addSubview(imagePrifile)
        screenView!.addSubview(signOutContainer)
        screenView!.addSubview(signOutButton)
        screenView!.addSubview(nicknameTextView)
        screenView!.addSubview(emaleTextView)
        screenView!.addSubview(genderTextView)
        

    }
    
    func layoutViews() {
        
        NSLayoutConstraint.activate([
            imagePrifile.topAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.topAnchor, constant: 40),
            imagePrifile.centerXAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.centerXAnchor),
            imagePrifile.heightAnchor.constraint(equalToConstant: 70),
            imagePrifile.widthAnchor.constraint(equalToConstant: 70),
            
            nicknameTextView.topAnchor.constraint(equalTo: imagePrifile.bottomAnchor, constant: 25),
            nicknameTextView.centerXAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.centerXAnchor),
            nicknameTextView.heightAnchor.constraint(equalToConstant: 25),
            nicknameTextView.widthAnchor.constraint(equalTo: screenView!.widthAnchor),
            
            emaleTextView.topAnchor.constraint(equalTo: nicknameTextView.bottomAnchor, constant: 25),
            emaleTextView.centerXAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.centerXAnchor),
            emaleTextView.heightAnchor.constraint(equalToConstant: 25),
            emaleTextView.widthAnchor.constraint(equalTo: screenView!.widthAnchor),
            
            genderTextView.topAnchor.constraint(equalTo: emaleTextView.bottomAnchor, constant: 25),
            genderTextView.centerXAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.centerXAnchor),
            genderTextView.heightAnchor.constraint(equalToConstant: 25),
            genderTextView.widthAnchor.constraint(equalTo: screenView!.widthAnchor),
            
            signOutContainer.topAnchor.constraint(equalTo: genderTextView.bottomAnchor, constant: 0),
            signOutContainer.leadingAnchor.constraint(equalTo: screenView!.leadingAnchor, constant: 50),
            signOutContainer.trailingAnchor.constraint(equalTo: screenView!.trailingAnchor, constant: -50),
            signOutContainer.bottomAnchor.constraint(equalTo: screenView!.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
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

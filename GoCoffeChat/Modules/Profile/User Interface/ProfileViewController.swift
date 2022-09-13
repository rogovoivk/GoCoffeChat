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
    
    public var interactor = ProfileInteractor()
    public var navigation: ProfileWireframe?
    public var profileView = ProfileView()
    
    
    @objc func pressedSignOutButton() {
        print("нажата кнопка ВЫЙТИ")
        do {
            try Auth.auth().signOut()
            navigation?.dismissApp()
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
        
        profileView.screenView = self.view
        profileView.profileViewController = self
        interactor.profileView = profileView
        profileView.setView()

    }
    
    func fetchUserAndSetupProfileData() {
        interactor.fetchUserAndSetupProfileData()
    }


}

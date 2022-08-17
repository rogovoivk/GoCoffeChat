//
//  TBViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 22.07.2022.
//

import UIKit
import Firebase

class TBViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        checkIfUserIsLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let item1 = PostsPoolViewController()
        let icon1 = UITabBarItem(title: "posts pool", image: UIImage(systemName: "pencil.circle"), selectedImage: UIImage(systemName: "pencil.circle.fill"))
        item1.tabBarItem = icon1
        
//        let item2 = PoolChatsViewController()
        let item2 = InDevelopingScreenViewController()
        let icon2 = UITabBarItem(title: "chats", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))
        item2.tabBarItem = icon2
        
        let item3 = ProfileViewController()
        let icon3 = UITabBarItem(title: "profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        item3.tabBarItem = icon3
        
        let controllers = [item1, item2, item3]
        self.viewControllers = controllers
        self.tabBar.backgroundColor = .darkGray
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.tintColor = .white
    }
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            fetchUserAndSetupNavBarTitle()
        }
    }
    
    @objc func handleLogout(){
        
    }
    
    func fetchUserAndSetupNavBarTitle() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            print(snapshot)
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//
//                let user = User(dictionary: dictionary)
//                self.setupNavBarWithUser(user)
//            }
            
        }, withCancel: nil)
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }

}

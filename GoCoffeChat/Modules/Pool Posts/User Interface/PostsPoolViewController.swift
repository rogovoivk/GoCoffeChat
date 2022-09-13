//
//  PoolPostsViewController.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 22.07.2022.
//

import UIKit
import Firebase

class PostsPoolViewController: UIViewController{

    var navigation: PoolPostsWireframe?
    var interactor = PoolPostsInteractor()
    var postsPoolView = PoolPostsView()
  
    
    @objc func handleNewPost(){
        navigation?.presentNewPostViewControllerInWindow()
    }
    
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()

        postsPoolView.screenView = self.view
        postsPoolView.postsPoolViewController = self
        interactor.postsPoolScreenView = postsPoolView
        postsPoolView.setView()
    }
    
 
    
//    func observePosts() {
//        interactor.observePosts()
//        
//    }
    
    


}


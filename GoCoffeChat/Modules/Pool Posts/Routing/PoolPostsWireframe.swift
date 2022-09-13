//
//  PoolPostsWireframe.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 25.08.2022.
//

import UIKit

class PoolPostsWireframe: NSObject, PoolPostsWireframeProtocol {
    
    var postsPoolScreenViewController: PostsPoolViewController?
    
    func presentNewPostViewControllerInWindow() {
        let newPostController = NewPostViewController()
        let interactorNewPost = NewPostInteractor()
        newPostController.interactor = interactorNewPost
        
        let vc = UINavigationController(rootViewController: newPostController)
        vc.modalPresentationStyle = .fullScreen
        postsPoolScreenViewController?.present(vc, animated: true, completion: nil)
//        postsPoolScreenViewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}

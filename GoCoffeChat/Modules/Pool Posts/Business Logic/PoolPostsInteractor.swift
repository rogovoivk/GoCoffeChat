//
//  PoolPostsInteractor.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 24.08.2022.
//

import UIKit
import Firebase

class PoolPostsInteractor: NSObject, PoolPostsInteractorProtocol {
    
    var postsPoolScreenView: PoolPostsView?
    
    func observePosts() {
        var posts = [Post]()
        
        let ref = Database.database().reference().child("posts")
        ref.observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let post = Post(dictionary: dictionary)
//                user.id = snapshot.key

                posts.append(post)
                posts.sort(by: { $0.timestamp!.intValue > $1.timestamp!.intValue})
                self.postsPoolScreenView?.posts = posts
                
                DispatchQueue.main.async(execute: {
                    self.postsPoolScreenView?.tableView.reloadData()
                })
            }
        }, withCancel: nil)
        
    }
    
    
}

//
//  NewPostInteractor.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 08.09.2022.
//

import UIKit
import Firebase

class NewPostInteractor: NSObject, NewPostInteractorProtocol {
    
    @objc func sendPost(textPost: String) {
        
        let ref = Database.database().reference().child("posts")
        let childRef = ref.childByAutoId()
        
        let userId = Auth.auth().currentUser!.uid
        let timestamp = Int(Date().timeIntervalSince1970)
        
        let values = ["userId": userId, "text": textPost, "timestamp": timestamp] as [String : Any]
        childRef.updateChildValues(values)
    }
    
}

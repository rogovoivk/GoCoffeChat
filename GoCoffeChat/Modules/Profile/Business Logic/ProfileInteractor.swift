//
//  ProfileInteractor.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 23.08.2022.
//

import UIKit
import Firebase

class ProfileInteractor: NSObject, ProfileInteractorProtocol {
    
    var profileView: ProfileView?
    
    func fetchUserAndSetupProfileData(){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { [self] (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User(dictionary: dictionary)
                self.profileView?.genProfileTextViews(textView: profileView!.nicknameTextView, text1: "",text2: user.nickname!)
                self.profileView?.genProfileTextViews(textView: profileView!.emaleTextView, text1: "email: ",text2: user.email!)
                self.profileView?.genProfileTextViews(textView: profileView!.genderTextView, text1: "пол: ", text2: user.gender!)
            }
            
        }, withCancel: nil)
    }
    
}

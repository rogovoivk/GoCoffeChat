//
//  SignUpInteractor.swift.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 24.08.2022.
//

import UIKit
import Firebase

class SignUpInteractor: NSObject, SignUpInteractorProtocol {
    
    var view: SignUpViewController?
    
    func createUser(email: String, nickname: String, password1: String, gender: String) -> Error?{

        
        var ansError: Error?
            Auth.auth().createUser(withEmail: email, password: password1) { result, error in
                ansError = error
                if error == nil{
                    if let result = result{
                        print("тут результат (id зарегестрированного пользователья)")
                        print(result.user.uid)
                        let ref = Database.database().reference().child("users")
                        ref.child(result.user.uid).updateChildValues(["email": email, "nickname": nickname, "gender": gender])
                        
//                        self.dismiss(animated: true)
                    }
                }
               
            }
        return ansError
        
    }
    
}

//
//  User.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 25.07.2022.
//

import UIKit

class User: NSObject {
    var id: String?
    var nickname: String?
    var email: String?
    var gender: String?
//    var profileImageUrl: String?
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.nickname = dictionary["nickname"] as? String
        self.email = dictionary["email"] as? String
        self.gender = dictionary["gender"] as? String
//        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}

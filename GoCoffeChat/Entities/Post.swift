//
//  Post.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 12.08.2022.
//

import UIKit
import FirebaseAuth

class Post: NSObject {

    var userId: String?
    var text: String?
    var images: [UIImage]?
    var timestamp: NSNumber?
    
    init(dictionary: [String: Any]) {
        self.userId = dictionary["userId"] as? String
        self.text = dictionary["text"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
    }
    
}

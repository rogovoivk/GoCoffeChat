//
//  ProfileWireframe.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 25.08.2022.
//

import UIKit

class ProfileWireframe: NSObject, ProfileWireframeProtocol {
    var profileViewController: ProfileViewController?
    
    func dismissApp() {
        self.profileViewController?.dismiss(animated: true, completion: nil)
    }
    

}

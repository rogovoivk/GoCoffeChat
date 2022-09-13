//
//  SignUpInteractorProtocol.swift
//  GoCoffeChat
//
//  Created by Vladoslav on 24.08.2022.
//

import Foundation

@objc protocol SignUpInteractorProtocol{
    func createUser(email: String, nickname: String, password1: String, gender: String) -> Error?
}

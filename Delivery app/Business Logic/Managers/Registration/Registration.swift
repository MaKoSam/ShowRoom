//
//  Registration.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 03/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation
import FirebaseAuth

final class Registration {
    func tryRegister(with email: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            completionHandler(error)
        }
    }
}

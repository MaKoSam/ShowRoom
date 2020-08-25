//
//  Authorization.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 03/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation
import FirebaseAuth

final class Authorization {
    func tryLogin(with email: String, password: String, completionHandler: @escaping (Error?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                completionHandler(error)
            }
        }
    }
}

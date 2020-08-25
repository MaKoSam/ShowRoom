//
//  UserManager.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 20/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class UserManager {
    let database = Firestore.firestore()
    var reference: DocumentReference? = nil
    
    func createUser(completionHandler: @escaping(User?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            guard let user = Auth.auth().currentUser,
                let email = user.email else {
                    completionHandler(nil)
                    return
            }
            self.database.collection("users").document(user.uid).setData([
                "email": email,
                "name": "Гость",
                "phone": "Телефон",
                "address": "Aдрес"
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            let activeUser = User(id: user.uid, email: email)
            Session.shared.activeUser = activeUser
            completionHandler(activeUser)
        }
    }
    
    func loginUser(completionHandler: @escaping (User?) -> Void) {
        DispatchQueue.global(qos: .default).async {
            guard let user = Auth.auth().currentUser,
                let email = user.email else {
                    completionHandler(nil)
                    return
            }
            self.reference = self.database.collection("users").document(user.uid)
            self.reference?.getDocument() { (document, error) in
                guard let document = document,
                    let vocabulary = document.data(),
                    let phone: String = vocabulary["phone"] as? String,
                    let name: String = vocabulary["name"] as? String,
                    let address: String = vocabulary["address"] as? String else {
                        completionHandler(nil)
                     return
                }
                let activeUser = User(id: user.uid, email: email, name: name, phone: phone, address: address)
                Session.shared.activeUser = activeUser
                completionHandler(activeUser)
                return
            }
        }
    }
    
    func updateUserName(name: String) {
        Session.shared.activeUser?.name = name
        DispatchQueue.global(qos: .default).async {
            if let user = Session.shared.activeUser {
                self.database.collection("users").document(user.id).updateData([
                    "name": name
                ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func updateUserEmail(email: String) {
        Session.shared.activeUser?.email = email
        Auth.auth().currentUser?.updateEmail(to: email) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        DispatchQueue.global(qos: .default).async {
            if let user = Session.shared.activeUser {
                self.database.collection("users").document(user.id).updateData([
                    "email": email
                ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func updateUserPhone(phone: String) {
        Session.shared.activeUser?.phone = phone
        DispatchQueue.global(qos: .default).async {
            if let user = Session.shared.activeUser {
                self.database.collection("users").document(user.id).updateData([
                    "phone": phone
                ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func updateUserAddress(address: String) {
        Session.shared.activeUser?.address = address
        DispatchQueue.global(qos: .default).async {
            if let user = Session.shared.activeUser {
                self.database.collection("users").document(user.id).updateData([
                    "address": address
                ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func logout() {
        Session.shared.activeUser = nil
        do {
            try Auth.auth().signOut()
        } catch {
            print("error signing out");
        }
    }
}

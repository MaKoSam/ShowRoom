//
//  User.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 20/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class User {
    var id: String = ""
    var email: String = ""
    var name: String = ""
    var phone: String = ""
    var address: String = ""
    
    init(id: String, email: String, name: String? = nil, phone: String? = nil, address: String? = nil) {
        self.id = id
        self.email = email
        if let name = name {
            self.name = name
        }
        if let phone = phone {
            self.phone = phone
        }
        if let address = address {
            self.address = address
        }
    }
}

//
//  Session.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 03/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation
import FirebaseAuth

final class Session {
    static let shared = Session()
    private init() { }
    
    let viewSettings: ViewSettings = ViewSettings()
    let restaurantManager: RestaurantManager = RestaurantManager()
    
    var activeUser: User?
    let userManager = UserManager()
    let orderManager = OrderManager()
}

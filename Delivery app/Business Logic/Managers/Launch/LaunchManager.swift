//
//  LaunchManager.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 03/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class LaunchManager {
    func configureShop(completionHandler: @escaping() -> Void) {
        Session.shared.restaurantManager.configureRestaurant {
            completionHandler()
        }
    }
    
    func configureUser() {
        Session.shared.userManager.loginUser() { user in
            print(user)
        }
    }
}

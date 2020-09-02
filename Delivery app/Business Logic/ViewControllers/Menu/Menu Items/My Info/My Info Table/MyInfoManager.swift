//
//  MyInfoManager.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 22/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class MyInfoManager {
    let items = ["Имя", "Телефон", "Почта", "Адрес"]
    var info = ["", "", "", ""]
    var numberOfRows = 4
    
    func updateInformation() {
        if let user = Session.shared.activeUser {
            info[0] = user.name
            info[1] = user.phone
            info[2] = user.email
            info[3] = user.address
        } else {
            numberOfRows = 0
        }
    }
}

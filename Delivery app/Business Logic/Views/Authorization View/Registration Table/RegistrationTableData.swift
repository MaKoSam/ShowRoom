//
//  RegistrationTableData.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 31/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class RegistrationTableData {
    let numberOfSections = 2
    let numberOfRowsInSection: [Int] = [3, 1]
    let titleForRowAtIndex: [String] = ["email".localized(),
                                        "password".localized(),
                                        "password_repeat".localized()]
    let emailIndexPath = IndexPath(row: 0, section: 0)
    let passwordIndexPath = IndexPath(row: 1, section: 0)
    let passwordRepeatIndexPath = IndexPath(row: 2, section: 0)
    let buttonTitle = "sign_up_action".localized()
}

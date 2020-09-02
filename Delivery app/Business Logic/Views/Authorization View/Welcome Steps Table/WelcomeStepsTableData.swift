//
//  WelcomeStepsTableData.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 31/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class WelcomeStepsTableData  {
    let numberOfSections = 2
    let numberOfRowsInSection: [Int] = [3, 1]
    let titleForRowAtIndex: [String] = ["name".localized(),
                                        "phone".localized(),
                                        "address".localized()]
    
    let nameIndexPath = IndexPath(row: 0, section: 0)
    let phoneIndexPath = IndexPath(row: 1, section: 0)
    let addressIndexPath = IndexPath(row: 2, section: 0)
    
    let buttonTitle = "sign_up_action".localized()
}

//
//  MenuTableData.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 01/06/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class MenuTableData {
    let authState: AuthState
    let user: User?
    
    let numberOfSections: Int
    let numberOfRowsInSection: [Int]
    
    let personalSectionTitles: [String] = ["my_order".localized(),
                                           "my_address".localized()]
    let personalSectionImage: [UIImage?] = [UIImage(named: "cart"),
                                           UIImage(named: "address")]
    let informationSectionTitle: [String] = ["delivery_info".localized(),
                                             "call_us".localized(),
                                             "feedback".localized(),
                                             "info".localized()]
    let informationSectionImage: [UIImage?] = [UIImage(named: "location"),
                                               UIImage(named: "call"),
                                               UIImage(named: "feedback"),
                                               UIImage(named: "info")]
    
    init(authState: AuthState){
        self.authState = authState
        switch authState {
        case .signedIn:
            numberOfSections = 3
            numberOfRowsInSection = [1, 2, 4]
        case .signedOut:
            numberOfSections = 2
            numberOfRowsInSection = [1, 4]
        }
        user = Session.shared.activeUser
    }
}

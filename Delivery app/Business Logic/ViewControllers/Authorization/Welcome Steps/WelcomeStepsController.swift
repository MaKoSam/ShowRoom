//
//  WelcomeStepsController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 18/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class WelcomeStepsController: UIViewController {
    //MARK: - Views
    let navigationView = NavigationView()
    let headline = HeadlineView()
    let stepsTable = WelcomeStepsTableView()
    
    //MARK: - Properties
    var constraints = [NSLayoutConstraint]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        headline.setTitle("steps".localized())
    }
}


//MARK: - Welcome Steps Table Delegate
extension WelcomeStepsController: WelcomeStepsTableDelegate {
    func handleRequest(request: StepsRequest) {
        guard let name = request.name,
            let phone = request.phone,
            let address = request.address else {
                return
        }
        
        Session.shared.userManager.updateUserName(name: name)
        Session.shared.userManager.updateUserPhone(phone: phone)
        Session.shared.userManager.updateUserAddress(address: address)
        AppDelegate.shared.rootViewController.navigateToShopBranch()
    }
}

//MARK: - Navigation Delegate
extension WelcomeStepsController: NavigationDelegate {
    func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

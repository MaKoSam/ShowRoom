//
//  AuthController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 20/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class AuthController: UIViewController {
    //MARK: - Subviews
    let navigationView = NavigationView()
    var backgroundView = UIImageView()
    
    var headlineImage = UIImageView()
    var headlineLabel = UILabel()
    
    var loginButton = UIButton()
    var registerButton = UIButton()
    
    //MARK: - Properties
    var constraints = [NSLayoutConstraint]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NSLayoutConstraint.activate(constraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func navigateToLogin(sender: UIButton) {
        let controllerBuilder = LoginControllerBuilder()
        let new = controllerBuilder.buildController()
        self.navigationController?.pushViewController(new, animated: true)
    }
    
    @objc func navigateToRegister(sender: UIButton) {
        let controllerBuilder = RegisterControllerBuilder()
        let new = controllerBuilder.buildController()
        self.navigationController?.pushViewController(new, animated: true)
    }
}

//MARK: - Navigation Delegate
extension AuthController: NavigationDelegate {
    func navigateBack() {
        AppDelegate.shared.rootViewController.navigateToShopBranch()
    }
}

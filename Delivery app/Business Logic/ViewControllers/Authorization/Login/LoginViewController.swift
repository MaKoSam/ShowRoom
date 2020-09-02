//
//  LoginViewController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 03/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    //MARK: - Subviews
    let navigationView = NavigationView()
    let headline = HeadlineView()
    let loginTable = LoginTableView()
    
    //MARK: - Properties
    var constraints = [NSLayoutConstraint]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headline.setTitle("sign_in".localized())
    }
}

//MARK: - Login Table Delegate
extension LoginViewController: LoginTableDelegate {
    func handleRequest(request: LoginRequest) {
        guard let email = request.email else {
            presentError(error: "Введите вашу почту")
            return
        }
        guard let password = request.password else {
            presentError(error: "Введите ваш пароль")
            return
        }
        let authorizator = Authorization()
        authorizator.tryLogin(with: email, password: password) { error in
            if let _ = error {
                self.presentError(error: "Почта или пароль неверны")
                return
            } else {
                Session.shared.userManager.loginUser() { user in
                    DispatchQueue.main.async {
                        if let _ = user {
                            AppDelegate.shared.rootViewController.navigateToShopBranch()
                            return
                        } else {
                            self.presentError(error: "Ошибка аутентификации")
                            return
                        }
                    }
                }
            }
        }
    }
    
    private func presentError(error message: String?) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

//MARK: - Navigation Delegate
extension LoginViewController: NavigationDelegate {
    func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

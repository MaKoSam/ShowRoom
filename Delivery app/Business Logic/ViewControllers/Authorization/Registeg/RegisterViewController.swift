//
//  RegisterViewController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 03/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class RegisterViewController: UIViewController {
    //MARK: - Subviews
    let navigationView = NavigationView()
    let headline = HeadlineView()
    let registerTable = RegistrationTableView()
    
    //MARK: - Properties
    var constraints = [NSLayoutConstraint]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headline.setTitle("sign_up".localized())
    }
}

//MARK: - Register Table Delegate
extension RegisterViewController: RegistrationTableDelegate {
    func handleRequest(request: RegisterRequest) {
        guard let email = request.email else {
            presentError(error: "Введите почту")
            return
        }
        guard let password = request.password,
            password.count >= 6 else {
            presentError(error: "Введите пароль. Пароль должен быть длинной 6 или более символов")
            return
        }
        guard let passwordRep = request.passwordRepeat,
            password == passwordRep else {
                presentError(error: "Пароли не совпадают")
                return
        }
        
        let registrator = Registration()
        registrator.tryRegister(with: email, password: password) { error in
            if let _ = error {
                self.presentError(error: "Почта уже используется другим аккаунтом")
                return
            } else {
                Session.shared.userManager.createUser() { user in
                    DispatchQueue.main.async {
                        if let _ = user {
                            let controllerBuilder = WelcomeStepsBuilder()
                            let new = controllerBuilder.buildController()
                            self.navigationController?.pushViewController(new, animated: true)
                            return
                        } else {
                            self.presentError(error: "Ошибка регистрации, попробуйте позже.")
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
extension RegisterViewController: NavigationDelegate {
    func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

//
//  AuthBuilder.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 20/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class AuthBuilder {
    private let controller: AuthController
    private let viewSettings: ViewSettings
    
    init() {
        controller = AuthController()
        viewSettings = Session.shared.viewSettings
    }
    
    func buildController() -> AuthController {
        addViews()
        configureConstraints()
        configureViews()
        return controller
    }
    
    private func addViews() {
        controller.backgroundView.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.backgroundView)
        
        controller.navigationView.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.navigationView)
        
        controller.headlineImage.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.headlineImage)
        
        controller.headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.headlineLabel)
        
        controller.loginButton.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.loginButton)
        
        controller.registerButton.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.registerButton)
    }
    
    private func configureConstraints() {
        controller.constraints = [
            controller.navigationView.topAnchor.constraint(equalTo: controller.view.topAnchor),
            controller.navigationView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            controller.navigationView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            controller.navigationView.heightAnchor.constraint(equalToConstant:
                viewSettings.statusBarHeightMargine + viewSettings.navigationBarHeightMargine),
            
            controller.backgroundView.topAnchor.constraint(equalTo: controller.view.topAnchor),
            controller.backgroundView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            controller.backgroundView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            controller.backgroundView.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor),
            
            controller.headlineImage.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor, constant: -150.0),
            controller.headlineImage.centerXAnchor.constraint(equalTo: controller.view.centerXAnchor),
            controller.headlineImage.heightAnchor.constraint(equalToConstant: 200.0),
            controller.headlineImage.widthAnchor.constraint(equalToConstant: 200.0),
            
            controller.headlineLabel.topAnchor.constraint(equalTo: controller.headlineImage.bottomAnchor,
                                                          constant: viewSettings.conteinerSpaceConstant),
            controller.headlineLabel.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor,
                                                              constant: viewSettings.conteinerSpaceConstant),
            controller.headlineLabel.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor,
                                                               constant: -viewSettings.conteinerSpaceConstant),
            
            controller.registerButton.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor,
                                                              constant: -viewSettings.homeIndicatorHeightMargine),
            controller.registerButton.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor,
                                                               constant: viewSettings.conteinerSpaceConstant),
            controller.registerButton.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor,
                                                                constant: -viewSettings.conteinerSpaceConstant),
            controller.registerButton.heightAnchor.constraint(equalToConstant: 60.0),
            
            controller.loginButton.bottomAnchor.constraint(equalTo: controller.registerButton.topAnchor,
                                                           constant: -viewSettings.conteinerSpaceConstant),
            controller.loginButton.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor,
                                                            constant: viewSettings.conteinerSpaceConstant),
            controller.loginButton.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor,
                                                             constant: -viewSettings.conteinerSpaceConstant),
            controller.loginButton.heightAnchor.constraint(equalToConstant: 60.0)
        ]
    }
    
    private func configureViews() {
        controller.view.backgroundColor = .white
        
        controller.navigationView.backgroundColor = nil
        controller.navigationView.delegate = controller
        
        controller.backgroundView.image = UIImage(named: "authBackground.png")
        controller.headlineImage.image = UIImage(named: "logo.png")
        
        controller.headlineLabel.text = "app_title".localized()
        controller.headlineLabel.addCharacterSpacing(kernValue: 5.0)
        controller.headlineLabel.textAlignment = .center
        controller.headlineLabel.font = viewSettings.titleFont
        controller.headlineLabel.textColor = .white
        
        controller.loginButton.layer.cornerRadius = viewSettings.buttonCornerRadius
        controller.loginButton.backgroundColor = .white
        controller.loginButton.setTitle("Войти", for: .normal)
        controller.loginButton.titleLabel?.font = viewSettings.contentFont
        controller.loginButton.setTitleColor(viewSettings.headerTextColor, for: .normal)
        controller.loginButton.addTarget(controller, action: #selector(AuthController.navigateToLogin(sender:)), for: .touchUpInside)
        
        controller.registerButton.layer.cornerRadius = viewSettings.buttonCornerRadius
        controller.registerButton.backgroundColor = viewSettings.lightBackgroundColor
        controller.registerButton.setTitle("Зарегистрироваться", for: .normal)
        controller.registerButton.titleLabel?.font = viewSettings.contentFont
        controller.registerButton.setTitleColor(viewSettings.lightTextColor, for: .normal)
        controller.registerButton.addTarget(controller, action: #selector(AuthController.navigateToRegister(sender:)), for: .touchUpInside)
    }
}

//
//  LoginControllerBuilder.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 03/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class LoginControllerBuilder {
    private let controller: LoginViewController
    private let viewSettings: ViewSettings
    
    init() {
        controller = LoginViewController()
        viewSettings = Session.shared.viewSettings
    }
    
    func buildController() -> LoginViewController {
        addViews()
        configureConstraints()
        configureViews()
        return controller
    }
    
    private func addViews() {
        controller.navigationView.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.navigationView)
        
        controller.headline.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.headline)
        
        controller.loginTable.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.loginTable)
    }
    
    private func configureConstraints() {
        controller.constraints = [
            controller.navigationView.topAnchor.constraint(equalTo: controller.view.topAnchor),
            controller.navigationView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            controller.navigationView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            controller.navigationView.heightAnchor.constraint(equalToConstant:
                viewSettings.statusBarHeightMargine + viewSettings.navigationBarHeightMargine),
            
            controller.headline.topAnchor.constraint(equalTo: controller.navigationView.bottomAnchor),
            controller.headline.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor,
                                                         constant: viewSettings.conteinerSpaceConstant),
            controller.headline.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor,
                                                          constant: -viewSettings.conteinerSpaceConstant),
            controller.headline.heightAnchor.constraint(equalToConstant: viewSettings.viewHeightConstant),
            
            controller.loginTable.topAnchor.constraint(equalTo: controller.headline.bottomAnchor),
            controller.loginTable.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            controller.loginTable.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            controller.loginTable.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor)
        ]
    }
    
    private func configureViews() {
        controller.view.backgroundColor = .white
        
        controller.navigationView.delegate = controller
        controller.loginTable.delegate = controller
    }
}

//
//  MenuBuilder.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 21/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class MenuBuilder {
    private let viewSettings: ViewSettings
    private let controller: MenuViewController
    
    init() {
        viewSettings = Session.shared.viewSettings
        controller = MenuViewController()
    }
    
    func buildController() -> MenuViewController {
        addViews()
        configureConstraints()
        configureViews()
        return controller
    }
    
    private func addViews() {
        controller.navigationView.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.navigationView)
        
        controller.menuTable.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.menuTable)
    }
    
    private func configureConstraints() {
        controller.constraints = [
            controller.navigationView.topAnchor.constraint(equalTo: controller.view.topAnchor),
            controller.navigationView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            controller.navigationView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            controller.navigationView.heightAnchor.constraint(equalToConstant:
                viewSettings.navigationBarHeightMargine + viewSettings.statusBarHeightMargine),
            
            controller.menuTable.topAnchor.constraint(equalTo: controller.navigationView.bottomAnchor,
                                                      constant: viewSettings.conteinerSpaceConstant),
            controller.menuTable.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            controller.menuTable.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            controller.menuTable.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor)
        ]
    }
    
    private func configureViews() {
        controller.view.backgroundColor = .white
        controller.navigationView.delegate = controller
        controller.menuTable.delegate = controller
    }
}

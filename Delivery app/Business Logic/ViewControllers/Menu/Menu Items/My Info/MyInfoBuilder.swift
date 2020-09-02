//
//  MyInfoBuilder.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 22/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class MyInfoBuilder {
    private let controller: MyInfoController
    private let viewSettings: ViewSettings
    
    init(){
        controller = MyInfoController()
        viewSettings = Session.shared.viewSettings
    }
    
    func buildController() -> MyInfoController {
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
        
        controller.infoTable.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.infoTable)
        
        controller.commitButton.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.commitButton)
    }
    
    private func configureConstraints() {
        controller.constraints = [
            controller.navigationView.topAnchor.constraint(equalTo: controller.view.topAnchor,
                                                           constant: viewSettings.statusBarHeightMargine),
            controller.navigationView.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            controller.navigationView.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            controller.navigationView.heightAnchor.constraint(equalToConstant: viewSettings.navigationBarHeightMargine),
            
            controller.headline.topAnchor.constraint(equalTo: controller.navigationView.bottomAnchor),
            controller.headline.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor,
                                                         constant: viewSettings.conteinerSpaceConstant),
            controller.headline.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor,
                                                          constant: -viewSettings.conteinerSpaceConstant),
            controller.headline.heightAnchor.constraint(equalToConstant: viewSettings.viewHeightConstant),
            
            controller.commitButton.heightAnchor.constraint(equalToConstant: 50.0),
            controller.commitButton.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor,
                                                             constant: viewSettings.conteinerSpaceConstant),
            controller.commitButton.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor,
                                                              constant: -viewSettings.conteinerSpaceConstant),
            controller.commitButton.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor,
                                                            constant: -viewSettings.conteinerSpaceConstant),
            
            controller.infoTable.topAnchor.constraint(equalTo: controller.headline.bottomAnchor,
                                                      constant: viewSettings.conteinerSpaceConstant),
            controller.infoTable.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            controller.infoTable.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            controller.infoTable.bottomAnchor.constraint(equalTo: controller.commitButton.topAnchor,
                                                         constant: -viewSettings.conteinerSpaceConstant)
        ]
    }
    
    private func configureViews() {
        controller.view.backgroundColor = .white
        
        controller.navigationView.delegate = controller
        
        controller.headline.textAlignment = .left
        controller.headline.textColor = viewSettings.darkBackgroundColor
        controller.headline.font = viewSettings.headerFont
        controller.headline.baselineAdjustment = .alignCenters
        controller.headline.text = "Моя информация"
        
        controller.commitButton.backgroundColor = viewSettings.lightBackgroundColor
        controller.commitButton.layer.cornerRadius = viewSettings.buttonCornerRadius
        controller.commitButton.addTarget(controller, action: #selector(MyInfoController.commitChanges(sender:)), for: .touchUpInside)
        controller.commitButton.titleLabel?.font = viewSettings.contentFont
        controller.commitButton.setTitleColor(viewSettings.lightTextColor, for: .normal)
        
        controller.infoTable.backgroundColor = .white
        controller.infoTable.separatorStyle = .none
        controller.infoTable.register(MyInfoCell.self, forCellReuseIdentifier: "info")
        controller.infoTable.rowHeight = 55.0
        controller.infoTable.dataSource = controller
    }
}

//
//  OrderConfirmationBuilder.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 21/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class OrderConfirmationBuilder {
    func buildController() -> OrderConfirmationController {
        var controller = OrderConfirmationController()
        controller = addViews(for: controller)
        controller.constraints = configureConstraints(for: controller)
        controller = configureViews(for: controller)
        return controller
    }
    
    func addViews(for controller: OrderConfirmationController) -> OrderConfirmationController {
        controller.backButtonView.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.backButtonView)
        
        controller.backButton.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.backButton)
        
        controller.headline.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.headline)
        
        controller.orderTable.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.orderTable)
        return controller
    }
    
    func configureConstraints(for controller: OrderConfirmationController) -> [NSLayoutConstraint] {
        return [
            controller.backButton.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 80.0),
            controller.backButton.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 16.0),
            controller.backButton.heightAnchor.constraint(equalToConstant: 35.0),
            controller.backButton.widthAnchor.constraint(equalToConstant: 35.0),
            
            controller.backButtonView.centerXAnchor.constraint(equalTo: controller.backButton.centerXAnchor),
            controller.backButtonView.centerYAnchor.constraint(equalTo: controller.backButton.centerYAnchor),
            controller.backButtonView.heightAnchor.constraint(equalToConstant: 20.0),
            controller.backButtonView.widthAnchor.constraint(equalToConstant: 20.0),
            
            controller.headline.centerYAnchor.constraint(equalTo: controller.backButton.centerYAnchor, constant: 5.0),
            controller.headline.leadingAnchor.constraint(equalTo: controller.backButton.trailingAnchor, constant: 16.0),
            controller.headline.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -16.0),
            
            controller.orderTable.topAnchor.constraint(equalTo: controller.headline.bottomAnchor, constant: 10.0),
            controller.orderTable.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 0.0),
            controller.orderTable.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: 0.0),
            controller.orderTable.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor, constant: 0.0)
        ]
    }
    
    func configureViews(for controller: OrderConfirmationController) -> OrderConfirmationController {
        controller.view.backgroundColor = .white
        
        controller.headline.text = "Ваш Заказ"
        controller.headline.textAlignment = .left
        controller.headline.backgroundColor = .white
        controller.headline.numberOfLines = 2
        controller.headline.adjustsFontSizeToFitWidth = true
        controller.headline.textColor = Session.shared.viewSettings.backgroundColor
        controller.headline.font = UIFont(name: "Rockwell-Bold", size: 30.0)
        
        controller.backButtonView.image = UIImage(named: "back.png")
        controller.backButtonView.contentMode = .scaleToFill
        
        controller.backButton.backgroundColor = Session.shared.viewSettings.backgroundColor
        controller.backButton.alpha = 0.2
        controller.backButton.layer.cornerRadius = 10.0
        controller.backButton.addTarget(controller, action: #selector(OrderConfirmationController.navigateBack(sender:)), for: .touchUpInside)
        
        controller.orderTable.backgroundColor = .white
        controller.orderTable.separatorStyle = .none
        controller.orderTable.register(OrderItemCell.self, forCellReuseIdentifier: "item")
        controller.orderTable.register(OrderDetailCell.self, forCellReuseIdentifier: "detail")
        controller.orderTable.register(OrderButtonCell.self, forCellReuseIdentifier: "button")
        controller.orderTable.delegate = controller
        controller.orderTable.dataSource = controller
        
        return controller
    }
}

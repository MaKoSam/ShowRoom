//
//  CartControllerBuilder.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 14/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class CartControllerBuilder {
    func buildController() -> CartViewController {
        var controller = CartViewController()
        controller = addViews(for: controller)
        controller.constraints = configureConstraints(for: controller)
        controller = configureViews(for: controller)
        return controller
    }
    private func addViews(for controller: CartViewController) -> CartViewController {
        controller.backButtonView.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.backButtonView)
        
        controller.backButton.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.backButton)
        
        controller.headline.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.headline)
        
        controller.checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.checkoutButton)
        
        controller.emptyCart.translatesAutoresizingMaskIntoConstraints = false
        controller.cartTable.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }
    
    private func configureConstraints(for controller: CartViewController) -> [NSLayoutConstraint] {
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
            
            controller.checkoutButton.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 16.0),
            controller.checkoutButton.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -16.0),
            controller.checkoutButton.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor, constant: -16.0),
            controller.checkoutButton.heightAnchor.constraint(equalToConstant: 50.0)
        ]
    }
    
    private func configureViews(for controller: CartViewController) -> CartViewController {
        controller.view.backgroundColor = .white
        
        controller.headline.text = "Корзина"
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
        controller.backButton.addTarget(controller, action: #selector(CartViewController.navigateBack(sender:)), for: .touchUpInside)
        
        controller.cartTable.backgroundColor = .white
        controller.cartTable.register(CartCell.self, forCellReuseIdentifier: "cart")
        controller.cartTable.rowHeight = 116.0
        controller.cartTable.separatorStyle = .none
        controller.cartTable.dataSource = controller
        controller.cartTable.delegate = controller
        
        
        controller.checkoutButton.backgroundColor = Session.shared.viewSettings.fourthColor
        controller.checkoutButton.setTitleColor(Session.shared.viewSettings.secondColor, for: .normal)
        controller.checkoutButton.titleLabel?.font = UIFont(name: "Rockwell-Bold", size: 17.0)
        controller.checkoutButton.layer.cornerRadius = 25.0
        controller.checkoutButton.addTarget(self, action: #selector(CartViewController.checkoutPressed), for: .touchUpInside)
        
        controller.imageManager = ImageManager(container: controller.cartTable)
        
        controller.tableConstraint = [
            controller.cartTable.topAnchor.constraint(equalTo: controller.headline.bottomAnchor, constant: 0.0),
            controller.cartTable.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 0.0),
            controller.cartTable.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: 0.0),
            controller.cartTable.bottomAnchor.constraint(equalTo: controller.checkoutButton.topAnchor, constant: -10.0)
        ]
        
        controller.emptyConstraint = [
            controller.emptyCart.topAnchor.constraint(equalTo: controller.headline.bottomAnchor, constant: 0.0),
            controller.emptyCart.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 0.0),
            controller.emptyCart.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: 0.0),
            controller.emptyCart.bottomAnchor.constraint(equalTo: controller.checkoutButton.topAnchor, constant: -10.0)
        ]
        return controller
    }
}

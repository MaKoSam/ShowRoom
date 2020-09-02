//
//  RestaurantControllerBuilder.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 10/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class RestaurantControllerBuilder {
    func buildController() -> RestaurantViewController {
        var controller = RestaurantViewController()
        controller = addSubviews(for: controller)
        controller = configureSubviews(for: controller)
        controller.constraints = configureConstraints(for: controller)
        return controller
    }
    
    private func addSubviews(for controller: RestaurantViewController) -> RestaurantViewController {
        controller.menuTable.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.menuTable)
        
        controller.controlBar.translatesAutoresizingMaskIntoConstraints = false
        controller.view.addSubview(controller.controlBar)
        
        controller.cartButton.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }
    
    private func configureSubviews(for controller: RestaurantViewController) -> RestaurantViewController {
        controller.controlBar.delegate = controller
        
        controller.tableHeader.frame.size = controller.tableHeaderSize
        controller.tableHeader.delegate = controller
        
        controller.menuTable.tableHeaderView = controller.tableHeader
        controller.menuTable.tableHeaderView?.bounds.size = controller.tableHeaderSize
        
        controller.menuTable.rowHeight = 250.0
        controller.menuTable.sectionHeaderHeight = 50.0
        
        controller.menuTable.backgroundColor = .white
        controller.menuTable.separatorStyle = .none
        controller.menuTable.register(FoodCell.self, forCellReuseIdentifier: "food")
        controller.menuTable.dataSource = controller
        controller.menuTable.delegate = controller
        controller.menuTable.showsHorizontalScrollIndicator = false
        
        controller.imageManager = ImageManager(container: controller.menuTable)
        
        controller.cartButton.backgroundColor = Session.shared.viewSettings.fourthColor
        controller.cartButton.setTitleColor(Session.shared.viewSettings.secondColor, for: .normal)
        controller.cartButton.setTitle("Перейти в корзину", for: .normal)
        controller.cartButton.addTarget(controller, action: #selector(controller.navigateToCart(sender:)), for: .touchUpInside)
        controller.cartButton.layer.cornerRadius = 20.0
        
        controller.detailCardHeight = 140.0 + controller.view.frame.width
        controller.hiddenFrame = CGRect(x: 0.0,
                                        y: controller.view.frame.height,
                                        width: controller.view.frame.width,
                                        height: controller.detailCardHeight)
        controller.presentedFrame = CGRect(x: 0.0,
                                           y: controller.view.frame.height - controller.detailCardHeight,
                                           width: controller.view.frame.width,
                                           height: controller.detailCardHeight)
        controller.detailCard = FoodItemDetailCardView(frame: controller.hiddenFrame)
        let panGuesterRecogniser = UIPanGestureRecognizer(target: controller, action: #selector(RestaurantViewController.panOnDetailCard(recognizer:)))
        
        controller.transparentView.addGestureRecognizer(panGuesterRecogniser)
        controller.detailCard.tapRecogniseView.addGestureRecognizer(panGuesterRecogniser)
        
        controller.transparentView.frame = controller.view.frame
        controller.transparentView.backgroundColor = .black
        controller.transparentView.alpha = 0.0
        return controller
    }
    
    private func configureConstraints(for controller: RestaurantViewController) -> [NSLayoutConstraint] {
        controller.cartButtonConstraints = [
            controller.cartButton.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor, constant: -20.0),
            controller.cartButton.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 16.0),
            controller.cartButton.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: -16.0),
            controller.cartButton.heightAnchor.constraint(equalToConstant: 60.0)
        ]
        return [
            controller.controlBar.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 0.0),
            controller.controlBar.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 0.0),
            controller.controlBar.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: 0.0),
            controller.controlBar.heightAnchor.constraint(equalToConstant: 130.0),
            
            controller.menuTable.topAnchor.constraint(equalTo: controller.view.topAnchor, constant: 0.0),
            controller.menuTable.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor, constant: 0.0),
            controller.menuTable.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor, constant: 0.0),
            controller.menuTable.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor, constant: 0.0)
        ]
    }
}

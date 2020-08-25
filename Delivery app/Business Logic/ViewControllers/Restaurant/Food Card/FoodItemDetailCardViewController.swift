//
//  FoodItemDetailCardViewController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 13/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class FoodItemDetailCardView: UIView {
    //MARK: - Views
    var foodImage = UIImageView()
    
    var name = UILabel()
    var describe = UILabel()
    var price = UILabel()
    
    var shadowView = UIView()
    var cartQuantity = UILabel()
    var tapRecogniseView = UIView()
    
    //MARK: - Properties
    var foodItem: FoodItem? {
        willSet {
            if let newValue = newValue {
                name.text = newValue.name
                describe.text = newValue.description
                price.text = "\(newValue.price)0 рублей"
                if let quantity = Session.shared.restaurantManager.cartManager.isInCart(id: newValue.id) {
                    qunatityNumber = quantity
                }
            }
        }
    }
    var qunatityNumber: Int = 0 {
        willSet {
            if newValue != 0 {
                cartQuantity.text = "В корзине \(newValue) шт."
                self.alternativeView()
            } else {
                self.defaultView()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(foodImage)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)
        
        describe.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(describe)
        
        price.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(price)
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(shadowView)
        
        cartQuantity.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cartQuantity)
        
        tapRecogniseView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tapRecogniseView)
    }
    
    private func configureConstraints() {
        price.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0).isActive = true
        price.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        price.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        price.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        describe.bottomAnchor.constraint(equalTo: price.topAnchor, constant: -10.0).isActive = true
        describe.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        describe.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        describe.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        name.bottomAnchor.constraint(equalTo: describe.topAnchor, constant: -10.0).isActive = true
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        name.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        foodImage.bottomAnchor.constraint(equalTo: name.topAnchor, constant: -10.0).isActive = true
        foodImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        foodImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: self.frame.width - 32.0).isActive = true
        
        shadowView.bottomAnchor.constraint(equalTo: name.topAnchor, constant: -10.0).isActive = true
        shadowView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: self.frame.width - 32.0).isActive = true
        
        cartQuantity.bottomAnchor.constraint(equalTo: name.topAnchor, constant: -10.0).isActive = true
        cartQuantity.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        cartQuantity.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        cartQuantity.heightAnchor.constraint(equalToConstant: self.frame.width - 32.0).isActive = true
        
        tapRecogniseView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tapRecogniseView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tapRecogniseView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tapRecogniseView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func configureViews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20.0
        
        
        foodImage.backgroundColor = UIColor.gray
        foodImage.layer.cornerRadius = 25.0
        foodImage.layer.masksToBounds = true
        foodImage.contentMode = .scaleAspectFill
        
        shadowView.alpha = 0.0
        shadowView.layer.cornerRadius = 25.0
        shadowView.layer.masksToBounds = true
        shadowView.backgroundColor = Session.shared.viewSettings.fourthColor
        
        cartQuantity.alpha = 0.0
        cartQuantity.textAlignment = .center
        cartQuantity.textColor = .white
        cartQuantity.font = UIFont(name: "Rockwell-Bold", size: 20.0)
        
        name.addCharacterSpacing(kernValue: 1.0)
        name.textColor = Session.shared.viewSettings.backgroundColor
        name.font = UIFont(name: "Rockwell", size: 20.0)
        name.numberOfLines = 3
        name.lineBreakMode = .byWordWrapping
        name.baselineAdjustment = .alignCenters
        
        describe.addCharacterSpacing(kernValue: 1.0)
        describe.textColor = Session.shared.viewSettings.fourthColor
        describe.font = UIFont(name: "Rockwell", size: 16.0)
        
        price.addCharacterSpacing(kernValue: 1.0)
        price.textColor = Session.shared.viewSettings.backgroundColor
        price.font = UIFont(name: "Rockwell-Bold", size: 17.0)
        
//        tapRecogniseView.backgroundColor = .green
    }
}

extension FoodItemDetailCardView {
    private func alternativeView() {
        UIView.animate(withDuration: 0.5) {
            self.shadowView.alpha = 0.5
            self.cartQuantity.alpha = 1.0
        }
    }
    
    private func defaultView() {
        UIView.animate(withDuration: 0.5) {
            self.shadowView.alpha = 0.0
            self.cartQuantity.alpha = 0.0
            self.cartQuantity.text = nil
        }
    }
}

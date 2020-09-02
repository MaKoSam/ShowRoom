//
//  RestaurantView.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 16/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class RestaurantView: UIView {
    //MARK: - Subviews
    var headlineImage = UIImageView(frame: .zero)
    
    var logoBackgroundView = UIView(frame: .zero)
    var logoView = UIImageView(frame: .zero)
    var breakLine = UIView(frame: .zero)
    var deliveryTimeLabel = UILabel(frame: .zero)
    var deliveryTimeIcon = UIImageView(frame: .zero)
    var workingHoursLabel = UILabel(frame: .zero)
    var workintHoursIcon = UIImageView(frame: .zero)
    
    var featuredView = FeaturedView(frame: .zero)
    
    
    //MARK: - Properties
    let promos = [
        UIImage(named: "promo.jpg")!,
        UIImage(named: "promo2.jpg")!,
        UIImage(named: "promo3.jpg")!,
        UIImage(named: "promo4.jpg")!
    ]
    
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
        headlineImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headlineImage)
        
        logoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoBackgroundView)
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoView)
        
        breakLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(breakLine)
        
        deliveryTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(deliveryTimeLabel)
        
        deliveryTimeIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(deliveryTimeIcon)
        
        workingHoursLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(workingHoursLabel)
        
        workintHoursIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(workintHoursIcon)
        
        featuredView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(featuredView)
    }
    
    private func configureConstraints() {
        headlineImage.topAnchor.constraint(equalTo: self.topAnchor, constant: -50.0).isActive = true
        headlineImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        headlineImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        headlineImage.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
        
        logoBackgroundView.topAnchor.constraint(equalTo: self.topAnchor, constant: 200.0).isActive = true
        logoBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        logoBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        logoBackgroundView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        logoView.topAnchor.constraint(equalTo: logoBackgroundView.topAnchor, constant: 5.0).isActive = true
        logoView.leadingAnchor.constraint(equalTo: logoBackgroundView.leadingAnchor, constant: 20.0).isActive = true
        logoView.trailingAnchor.constraint(equalTo: logoBackgroundView.trailingAnchor, constant: -20.0).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        
        breakLine.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 0.0).isActive = true
        breakLine.leadingAnchor.constraint(equalTo: logoBackgroundView.leadingAnchor, constant: 20.0).isActive = true
        breakLine.trailingAnchor.constraint(equalTo: logoBackgroundView.trailingAnchor, constant: -20.0).isActive = true
        breakLine.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        deliveryTimeIcon.topAnchor.constraint(equalTo: breakLine.bottomAnchor, constant: 15.0).isActive = true
        deliveryTimeIcon.leadingAnchor.constraint(equalTo: logoBackgroundView.leadingAnchor, constant: 55.0).isActive = true
        deliveryTimeIcon.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        deliveryTimeIcon.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        deliveryTimeLabel.centerYAnchor.constraint(equalTo: deliveryTimeIcon.centerYAnchor, constant: 1.0).isActive = true
        deliveryTimeLabel.leadingAnchor.constraint(equalTo: deliveryTimeIcon.trailingAnchor, constant: 10.0).isActive = true
        deliveryTimeLabel.trailingAnchor.constraint(equalTo: logoBackgroundView.trailingAnchor, constant: -20.0).isActive = true
        deliveryTimeLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        workintHoursIcon.topAnchor.constraint(equalTo: deliveryTimeIcon.bottomAnchor, constant: 15.0).isActive = true
        workintHoursIcon.leadingAnchor.constraint(equalTo: logoBackgroundView.leadingAnchor, constant: 55.0).isActive = true
        workintHoursIcon.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        workintHoursIcon.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        workingHoursLabel.centerYAnchor.constraint(equalTo: workintHoursIcon.centerYAnchor, constant: 1.0).isActive = true
        workingHoursLabel.leadingAnchor.constraint(equalTo: workintHoursIcon.trailingAnchor, constant: 10.0).isActive = true
        workingHoursLabel.trailingAnchor.constraint(equalTo: logoBackgroundView.trailingAnchor, constant: -20.0).isActive = true
        workingHoursLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        featuredView.topAnchor.constraint(equalTo: logoBackgroundView.bottomAnchor, constant: 16.0).isActive = true
        featuredView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        featuredView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        featuredView.heightAnchor.constraint(greaterThanOrEqualToConstant: 305.0).isActive = true
    }
        
    private func configureViews() {
        self.backgroundColor = UIColor.white
        
        headlineImage.contentMode = .scaleAspectFill
        headlineImage.layer.masksToBounds = true
        headlineImage.animationImages = promos
        headlineImage.animationDuration = 15
        headlineImage.animationRepeatCount = 0
        headlineImage.startAnimating()
        
        logoBackgroundView.layer.cornerRadius = 10.0
        logoBackgroundView.layer.shadowColor = UIColor.black.cgColor
        logoBackgroundView.layer.shadowOpacity = 0.5
        logoBackgroundView.layer.shadowRadius = 10
//        logoBackgroundView.layer.shadowPath = UIBezierPath(rect: logoBackgroundView.frame).cgPath
        logoBackgroundView.backgroundColor = .white
        
        logoView.image = UIImage(named: "headline.jpg")
        logoView.contentMode = .scaleAspectFit
        
        breakLine.backgroundColor = Session.shared.viewSettings.fourthColor
        
        deliveryTimeLabel.text = "Доставим за 50-60 минут"
        deliveryTimeLabel.adjustsFontSizeToFitWidth = true
        deliveryTimeLabel.addCharacterSpacing(kernValue: 1.0)
        deliveryTimeLabel.textColor = Session.shared.viewSettings.backgroundColor
        deliveryTimeLabel.font = UIFont(name: "Rockwell", size: 15.0)
        
        deliveryTimeIcon.contentMode = .scaleToFill
        deliveryTimeIcon.image = UIImage(named: "deliveryTime.png")
        
        workingHoursLabel.text = "Ежедневно с 12:30 до 21:30"
        workingHoursLabel.adjustsFontSizeToFitWidth = true
        workingHoursLabel.addCharacterSpacing(kernValue: 1.0)
        workingHoursLabel.textColor = Session.shared.viewSettings.backgroundColor
        workingHoursLabel.font = UIFont(name: "Rockwell", size: 15.0)
        
        workintHoursIcon.contentMode = .scaleToFill
        workintHoursIcon.image = UIImage(named: "workingHours.png")
    }
}

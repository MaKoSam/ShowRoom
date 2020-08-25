//
//  DeliveryPriceController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 22/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class DeliveryPriceController: UIViewController {
    //MARK: - Subviews
    let navigationView = NavigationView()
    var headline = UILabel()
    
    var imageView = UIImageView()
    
    var moreThanMinPriceLabel = UILabel()
    var lessThanMinPriceLabel = UILabel()
    
    var closeLabel = UILabel()
    var farLabel = UILabel()
    
    var closeFreeLabel = UILabel()
    var farFreeLabel = UILabel()
    
    //MARK: - Properties
    let viewSettings = Session.shared.viewSettings
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addViews()
        configureConstraints()
        configureViews()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DeliveryPriceController {
    private func addViews(){
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationView)
        
        headline.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headline)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        moreThanMinPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(moreThanMinPriceLabel)
        
        closeFreeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(closeFreeLabel)
        
        farFreeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(farFreeLabel)
        
        lessThanMinPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(lessThanMinPriceLabel)
        
        closeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(closeLabel)
        
        farLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(farLabel)
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.topAnchor,
                                                           constant: viewSettings.statusBarHeightMargine),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: viewSettings.navigationBarHeightMargine),
            
            headline.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            headline.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                         constant: viewSettings.conteinerSpaceConstant),
            headline.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                          constant: -viewSettings.conteinerSpaceConstant),
            headline.heightAnchor.constraint(equalToConstant: viewSettings.viewHeightConstant),
            
            imageView.topAnchor.constraint(equalTo: headline.bottomAnchor,
                                           constant: viewSettings.conteinerSpaceConstant),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300.0),
            
            moreThanMinPriceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,
                                                       constant: viewSettings.conteinerSpaceConstant),
            moreThanMinPriceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                           constant: viewSettings.conteinerSpaceConstant),
            moreThanMinPriceLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                            constant: -viewSettings.conteinerSpaceConstant),
            moreThanMinPriceLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            closeFreeLabel.topAnchor.constraint(equalTo: moreThanMinPriceLabel.bottomAnchor, constant: 10.0),
            closeFreeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            closeFreeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            closeFreeLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            farFreeLabel.topAnchor.constraint(equalTo: closeFreeLabel.bottomAnchor, constant: 10.0),
            farFreeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            farFreeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            farFreeLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            lessThanMinPriceLabel.topAnchor.constraint(equalTo: farFreeLabel.bottomAnchor, constant: 50.0),
            lessThanMinPriceLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            lessThanMinPriceLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            lessThanMinPriceLabel.heightAnchor.constraint(equalToConstant: 30.0),
            
            closeLabel.topAnchor.constraint(equalTo: lessThanMinPriceLabel.bottomAnchor, constant: 10.0),
            closeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            closeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            closeLabel.heightAnchor.constraint(equalToConstant: 20.0),
            
            farLabel.topAnchor.constraint(equalTo: closeLabel.bottomAnchor, constant: 10.0),
            farLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32.0),
            farLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            farLabel.heightAnchor.constraint(equalToConstant: 20.0)
        ])
    }
    
    private func configureViews() {
        self.view.backgroundColor = .white
        
        navigationView.delegate = self
        
        imageView.image = UIImage(named: "promo.jpg")
        imageView.contentMode = .scaleAspectFit
        
        headline.text = "Стоимость Доставки"
        headline.textAlignment = .left
        headline.textColor = viewSettings.darkTextColor
        headline.font = viewSettings.headerFont
        headline.numberOfLines = 2
        headline.lineBreakMode = .byClipping
        headline.baselineAdjustment = .alignCenters
        
        moreThanMinPriceLabel.text = "При сумме заказа свыше 2000 рублей:"
        moreThanMinPriceLabel.addCharacterSpacing(kernValue: 1.0)
        moreThanMinPriceLabel.numberOfLines = 2
        moreThanMinPriceLabel.lineBreakMode = .byWordWrapping
        moreThanMinPriceLabel.font = UIFont(name: "Rockwell-Bold", size: 16.0)
        moreThanMinPriceLabel.textColor = viewSettings.headerTextColor
        moreThanMinPriceLabel.backgroundColor = .white
        
        closeFreeLabel.text = "В пределах 10 км - БЕСПЛАТНО"
        closeFreeLabel.addCharacterSpacing(kernValue: 1.0)
        closeFreeLabel.font = UIFont(name: "Rockwell", size: 15.0)
        closeFreeLabel.textColor = viewSettings.darkTextColor
        closeFreeLabel.backgroundColor = .white
        
        farFreeLabel.text = "До центра г.Перми - 1000 рублей"
        farFreeLabel.addCharacterSpacing(kernValue: 1.0)
        farFreeLabel.font = UIFont(name: "Rockwell", size: 15.0)
        farFreeLabel.textColor = viewSettings.darkTextColor
        farFreeLabel.backgroundColor = .white
        
        lessThanMinPriceLabel.text = "При сумме заказа ниже 2000 рублей:"
        lessThanMinPriceLabel.addCharacterSpacing(kernValue: 1.0)
        lessThanMinPriceLabel.numberOfLines = 2
        lessThanMinPriceLabel.lineBreakMode = .byWordWrapping
        lessThanMinPriceLabel.font = UIFont(name: "Rockwell-Bold", size: 16.0)
        lessThanMinPriceLabel.textColor = viewSettings.headerTextColor
        lessThanMinPriceLabel.backgroundColor = .white
        
        closeLabel.text = "В пределах 10 км - 150 рублей"
        closeLabel.addCharacterSpacing(kernValue: 1.0)
        closeLabel.font = UIFont(name: "Rockwell", size: 15.0)
        closeLabel.textColor = viewSettings.darkTextColor
        closeLabel.backgroundColor = .white
        
        farLabel.text = "До центра г.Перми - 1000 рублей"
        farLabel.addCharacterSpacing(kernValue: 1.0)
        farLabel.font = UIFont(name: "Rockwell", size: 15.0)
        farLabel.textColor = viewSettings.darkTextColor
        farLabel.backgroundColor = .white
    }
}

//MARK: - Navigation Delegate
extension DeliveryPriceController: NavigationDelegate {
    func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

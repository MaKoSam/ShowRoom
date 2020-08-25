//
//  ControlBar.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 17/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class ControlBar: UIView {
    //MARK: - Subviews
    var backgroundView = UIView()
    var menuView = UIView()
    var menuButton = UIButton()
    
    var cartView = UIView()
    var cartButton = UIButton()
    
    var nameLabel = UILabel()
    //MARK: - Delegate
    var delegate: BarDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backgroundView)
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(menuView)
        
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(menuButton)
        
        cartView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cartView)
        
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cartButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
    }
    
    private func configureViews() {
        backgroundView.backgroundColor = .white
        backgroundView.alpha = 0.0
        
        menuView.backgroundColor = UIColor.white
        menuView.alpha = 0.9
        cartView.alpha = 0.9
        cartView.backgroundColor = UIColor.white

        menuView.layer.cornerRadius = 25.0
        cartView.layer.cornerRadius = 25.0
        
        menuButton.setImage(UIImage(named: "menu.png"), for: .normal)
        menuButton.contentMode = .scaleAspectFit
        
        cartButton.setImage(UIImage(named: "cart.png"), for: .normal)
        cartButton.contentMode = .scaleAspectFit
        
        nameLabel.alpha = 0.0
        nameLabel.text = "Охотничьи Сезоны"
        nameLabel.addCharacterSpacing(kernValue: 1.0)
        nameLabel.textColor = Session.shared.viewSettings.backgroundColor
        nameLabel.font = UIFont(name: "Rockwell-Bold", size: 34.0)
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureConstraints() {
        backgroundView.frame = self.frame
        menuView.topAnchor.constraint(equalTo: self.topAnchor, constant: 70.0).isActive = true
        menuView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        menuView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        menuView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        menuButton.centerYAnchor.constraint(equalTo: menuView.centerYAnchor, constant: 0.0).isActive = true
        menuButton.centerXAnchor.constraint(equalTo: menuView.centerXAnchor, constant: 0.0).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        menuButton.addTarget(self, action: #selector(ControlBar.navigateToMenu(sender:)), for: .touchUpInside)
        
        cartView.topAnchor.constraint(equalTo: self.topAnchor, constant: 70.0).isActive = true
        cartView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        cartView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        cartView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        cartButton.centerYAnchor.constraint(equalTo: cartView.centerYAnchor, constant: 0.0).isActive = true
        cartButton.centerXAnchor.constraint(equalTo: cartView.centerXAnchor, constant: 0.0).isActive = true
        cartButton.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        cartButton.widthAnchor.constraint(equalToConstant: 20.0).isActive = true
        cartButton.addTarget(self, action: #selector(ControlBar.navigateToCart(sender:)), for: .touchUpInside)
        
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70.0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: menuView.trailingAnchor, constant: 10.0).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: cartView.leadingAnchor, constant: -10.0).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
}

extension ControlBar {
    @objc func navigateToMenu(sender: UIButton) {
        delegate?.menuPressed()
    }
    
    @objc func navigateToCart(sender: UIButton) {
        delegate?.carPressed()
    }
}

protocol BarDelegate {
    func menuPressed()
    
    func carPressed()
}

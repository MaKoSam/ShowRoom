//
//  NoItemsView.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 15/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class EmptyCartView: UIView {
    //MARK: - Views
    var imageView = UIImageView()
    var label = UILabel()

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
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
    }
    
    private func configureConstraints() {
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50.0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50.0).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0.0).isActive = true
    }
    
    private func configureViews() {
        self.backgroundColor = .white
        label.backgroundColor = .white
        label.text = "Корзина Пуста"
        label.textColor = Session.shared.viewSettings.backgroundColor
        label.font = UIFont(name: "Rockwell-bold", size: 34.0)
        label.addCharacterSpacing(kernValue: 1.0)
    }
}

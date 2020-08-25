//
//  FeaturedCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 05/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class FeaturedCell: UICollectionViewCell {
    var image = UIImageView(frame: .zero)
    var name = UILabel(frame: .zero)
    var price = UILabel(frame: .zero)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubviews()
        configureViews()
        configureConstraints()
    }
    
    private func addSubviews() {
        image.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(image)
        name.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(name)
        price.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(price)
    }
    
    private func configureViews() {
        name.textAlignment = .left
        name.textColor = Session.shared.viewSettings.fourthColor
        name.numberOfLines = 3
        name.lineBreakMode = .byWordWrapping
        name.font = UIFont(name: "Rockwell", size: 17.0)
        name.addCharacterSpacing(kernValue: 1.0)
        
        price.textAlignment = .left
        price.textColor = Session.shared.viewSettings.backgroundColor
        price.font = UIFont(name: "Rockwell-Bold", size: 16.0)
        price.addCharacterSpacing(kernValue: 1.0)
        
        image.backgroundColor = UIColor.gray
        image.layer.cornerRadius = 25.0
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
    }
    
    private func configureConstraints() {
        image.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0).isActive = true
        image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5.0).isActive = true
        image.widthAnchor.constraint(equalToConstant: 360.0).isActive = true
        image.heightAnchor.constraint(equalToConstant: 200.0).isActive = true

        name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 15.0).isActive = true
        name.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15.0).isActive = true
        name.widthAnchor.constraint(equalToConstant: 340.0).isActive = true
        name.heightAnchor.constraint(greaterThanOrEqualToConstant: 20.0).isActive = true

        price.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10.0).isActive = true
        price.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15.0).isActive = true
        price.widthAnchor.constraint(equalToConstant: 340.0).isActive = true
        price.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
        price.text = nil
        image.image = nil
        image.backgroundColor = UIColor.gray
    }
}

//
//  CartCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 14/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {
    //MARK: - Subviwes
    var name = UILabel()
    var price = UILabel()
    var foodImage = UIImageView()
    var quantity = UILabel()
    var addButton = UIButton()
    var deleteButton = UIButton()
    
    //MARK: - Properties
    var id = 0
    
    //MARK: - Delegate
    var delegate: CartItemDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        foodImage.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(foodImage)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(name)
        
        price.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(price)
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(deleteButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(addButton)
        
        quantity.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(quantity)
    }
    
    func configureConstraints() {
        foodImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0).isActive = true
        foodImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0).isActive = true
        foodImage.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        
        name.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0).isActive = true
        name.leadingAnchor.constraint(equalTo: self.foodImage.trailingAnchor, constant: 10.0).isActive = true
        name.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0).isActive = true
        name.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        addButton.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 10.0).isActive = true
        addButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        quantity.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 10.0).isActive = true
        quantity.trailingAnchor.constraint(equalTo: self.addButton.leadingAnchor, constant: -10.0).isActive = true
        quantity.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        quantity.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 10.0).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: quantity.leadingAnchor, constant: -10.0).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        price.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 10.0).isActive = true
        price.leadingAnchor.constraint(equalTo: self.foodImage.trailingAnchor, constant: 10.0).isActive = true
        price.trailingAnchor.constraint(equalTo: self.deleteButton.leadingAnchor, constant: -10.0).isActive = true
        price.heightAnchor.constraint(lessThanOrEqualToConstant: 40.0).isActive = true
    }
    
    func configureViews() {
        self.backgroundColor = .white
        
        foodImage.backgroundColor = UIColor.gray
        foodImage.layer.cornerRadius = 20.0
        foodImage.layer.masksToBounds = true
        foodImage.contentMode = .scaleAspectFill
        
        addButton.setTitleColor(Session.shared.viewSettings.fourthColor, for: .normal)
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont(name: "Rockwell-Bold", size: 20.0)
        addButton.layer.borderWidth = 1.0
        addButton.layer.cornerRadius = 20.0
        addButton.layer.borderColor = Session.shared.viewSettings.fourthColor.cgColor
        addButton.addTarget(self, action: #selector(addToCart(sender:)), for: .touchUpInside)
        
        deleteButton.setTitleColor(Session.shared.viewSettings.fourthColor, for: .normal)
        deleteButton.setTitle("-", for: .normal)
        deleteButton.titleLabel?.font = UIFont(name: "Rockwell-Bold", size: 20.0)
        deleteButton.layer.borderWidth = 1.0
        deleteButton.layer.cornerRadius = 20.0
        deleteButton.layer.borderColor = Session.shared.viewSettings.fourthColor.cgColor
        deleteButton.addTarget(self, action: #selector(removeFromCart(sender:)), for: .touchUpInside)
        
        quantity.textAlignment = .center
        quantity.textColor = Session.shared.viewSettings.backgroundColor
        quantity.font = UIFont(name: "Rockwell-Bold", size: 16.0)
        quantity.addCharacterSpacing(kernValue: 1.0)
        
        name.addCharacterSpacing(kernValue: 1.0)
        name.textColor = Session.shared.viewSettings.fourthColor
        name.font = UIFont(name: "Rockwell", size: 17.0)
        name.numberOfLines = 3
        name.lineBreakMode = .byWordWrapping
        name.baselineAdjustment = .alignCenters
        
        price.addCharacterSpacing(kernValue: 1.0)
        price.textColor = Session.shared.viewSettings.backgroundColor
        price.font = UIFont(name: "Rockwell-Bold", size: 16.0)
        price.baselineAdjustment = .alignCenters
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.foodImage.image = nil
        self.name.text = nil
        self.price.text = nil
        self.quantity.text = nil
    }
    
}

extension CartCell {
    @objc func addToCart(sender: UIButton) {
        delegate?.addItem(self, item: id)
    }
    
    @objc func removeFromCart(sender: UIButton) {
        delegate?.removeItem(self, item: id)
    }
}

protocol CartItemDelegate {
    func addItem(_ sender: CartCell, item id: Int)
    func removeItem(_ sender: CartCell, item id: Int)
}

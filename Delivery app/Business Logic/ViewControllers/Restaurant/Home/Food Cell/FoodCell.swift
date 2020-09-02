//
//  FoodCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 08/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {
    //MARK: - Subviews
    var foodImage = UIImageView()
    
    var price = UILabel()
    var name = UILabel()
    
    var addButton = UIButton()
    var deleteButton = UIButton()
    
    var shadowView = UIView()
    var cartQuantity = UILabel()
    
    //MARK: - Properties
    private var AddButtonHeight = NSLayoutConstraint()
    
    var itemId: Int = 0 {
        willSet {
            if let itemsCount = Session.shared.restaurantManager.cartManager.isInCart(id: newValue) {
                qunatityNumber = itemsCount
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
    
    //MARK: - Delegate
    var delegate: PresentCartDelegate?
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
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
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(shadowView)
        
        cartQuantity.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cartQuantity)
    }
    
    private func configureConstraints() {
        addButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0).isActive = true
        addButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        AddButtonHeight = addButton.heightAnchor.constraint(equalToConstant: 190.0)
        AddButtonHeight.isActive = true
        
        foodImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0).isActive = true
        foodImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0).isActive = true
        foodImage.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10).isActive = true
        foodImage.heightAnchor.constraint(equalToConstant: 190.0).isActive = true
        
        shadowView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0).isActive = true
        shadowView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: self.addButton.leadingAnchor, constant: -10.0).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        cartQuantity.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0).isActive = true
        cartQuantity.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0).isActive = true
        cartQuantity.trailingAnchor.constraint(equalTo: self.addButton.leadingAnchor, constant: -10.0).isActive = true
        cartQuantity.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        name.topAnchor.constraint(equalTo: self.foodImage.bottomAnchor, constant: 10.0).isActive = true
        name.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0).isActive = true
        name.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -50.0).isActive = true
        name.heightAnchor.constraint(lessThanOrEqualToConstant: 50.0).isActive = true
        
        price.topAnchor.constraint(equalTo: self.foodImage.bottomAnchor, constant: 10.0).isActive = true
        price.leadingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -40.0).isActive = true
        price.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0).isActive = true
        price.heightAnchor.constraint(lessThanOrEqualToConstant: 50.0).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: self.addButton.bottomAnchor, constant: 0.0).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: self.price.topAnchor, constant: -10.0).isActive = true
    }
    
    private func configureViews() {
        self.contentView.backgroundColor = .white
        
        foodImage.backgroundColor = UIColor.gray
        foodImage.layer.cornerRadius = 25.0
        foodImage.layer.masksToBounds = true
        foodImage.contentMode = .scaleAspectFill
        
        addButton.setTitleColor(Session.shared.viewSettings.fourthColor, for: .normal)
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont(name: "Rockwell-Bold", size: 20.0)
        addButton.layer.borderWidth = 1.0
        addButton.layer.cornerRadius = 25.0
        addButton.layer.borderColor = Session.shared.viewSettings.fourthColor.cgColor
        addButton.addTarget(self, action: #selector(addToCart(sender:)), for: .touchUpInside)
        
        deleteButton.setTitleColor(Session.shared.viewSettings.fourthColor, for: .normal)
        deleteButton.setTitle("-", for: .normal)
        deleteButton.titleLabel?.font = UIFont(name: "Rockwell-Bold", size: 20.0)
        deleteButton.layer.borderWidth = 1.0
        deleteButton.layer.cornerRadius = 25.0
        deleteButton.layer.borderColor = Session.shared.viewSettings.fourthColor.cgColor
        deleteButton.addTarget(self, action: #selector(removeFromCart(sender:)), for: .touchUpInside)
        deleteButton.alpha = 0.0
        
        shadowView.alpha = 0.0
        shadowView.layer.cornerRadius = 25.0
        shadowView.layer.masksToBounds = true
        shadowView.backgroundColor = Session.shared.viewSettings.fourthColor
        
        cartQuantity.alpha = 0.0
        cartQuantity.textAlignment = .center
        cartQuantity.textColor = .white
        cartQuantity.font = UIFont(name: "Rockwell-Bold", size: 20.0)
        
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
        foodImage.image = nil
        name.text = nil
        price.text = nil
        cartQuantity.text = nil
        
        deleteButton.alpha = 0.0
        shadowView.alpha = 0.0
        cartQuantity.alpha = 0.0
        AddButtonHeight.constant = 190
    }
}

extension FoodCell {
    @objc func addToCart(sender: UIButton) {
        self.qunatityNumber = Session.shared.restaurantManager.cartManager.addItem(id: self.itemId)
        self.delegate?.addToCart(self)
    }
    
    @objc func removeFromCart(sender: UIButton) {
        self.qunatityNumber = Session.shared.restaurantManager.cartManager.deleteItem(id: self.itemId)
        self.delegate?.removeFromCart(self)
    }
    
    private func alternativeView() {
        if AddButtonHeight.constant != 100 {
            AddButtonHeight.constant = 100
        }
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
            self.deleteButton.alpha = 1.0
            self.shadowView.alpha = 0.5
            self.cartQuantity.alpha = 1.0
        }
    }
    
    private func defaultView() {
        if AddButtonHeight.constant != 190 {
            AddButtonHeight.constant = 190
        }
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
            self.deleteButton.alpha = 0.0
            self.shadowView.alpha = 0.0
            self.cartQuantity.alpha = 0.0
            self.cartQuantity.text = nil
        }
    }
}

protocol PresentCartDelegate {
    func addToCart(_ tappedCel: FoodCell)

    func removeFromCart(_ tappedCell: FoodCell)
}

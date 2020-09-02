//
//  OrderItemCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 25/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class OrderItemCell: UITableViewCell {
    //MARK: - Subviews
    let itemName = UILabel()
    let itemPrice = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func addViews() {
        itemName.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(itemName)
        
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(itemPrice)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            itemName.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0),
            itemName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            itemName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100.0),
            itemName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0),
            
            itemPrice.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0),
            itemPrice.leadingAnchor.constraint(equalTo: itemName.trailingAnchor, constant: 10.0),
            itemPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            itemPrice.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0)
        ])
    }
    
    private func configureViews() {
        self.backgroundColor = .white
        
        itemName.textAlignment = .left
        itemName.backgroundColor = .white
        itemName.numberOfLines = 2
        itemName.lineBreakMode = .byWordWrapping
        itemName.textColor = Session.shared.viewSettings.backgroundColor
        itemName.font = UIFont(name: "Rockwell", size: 15.0)
        
        itemPrice.textAlignment = .right
        itemPrice.backgroundColor = .white
        itemPrice.textColor = Session.shared.viewSettings.backgroundColor
        itemPrice.font = UIFont(name: "Rockwell-Bold", size: 15.0)
    }
}


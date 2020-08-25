//
//  CategoryCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 16/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    //MARK: - Subviews
    var categoryButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
    
    //MARK: - Properties
    var delegate: CategorySelectDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureCosntraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(categoryButton)
    }
    
    private func configureCosntraints() {
//        categoryButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 100.0).isActive = true
    }
    
    private func configureViews() {
        categoryButton.layer.cornerRadius = 10.0
        categoryButton.backgroundColor = Session.shared.viewSettings.fourthColor
        categoryButton.setTitleColor(Session.shared.viewSettings.secondColor, for: .normal)
        categoryButton.titleLabel?.font = UIFont(name: "Rockwell", size: 17.0)
        categoryButton.titleLabel?.numberOfLines = 2
        categoryButton.titleLabel?.lineBreakMode = .byWordWrapping
        categoryButton.titleLabel?.textAlignment = .center
        categoryButton.addTarget(self, action: #selector(CategoryCell.categorySetSelected(sender:)), for: .touchUpInside)
    }
    
    @objc func categorySetSelected(sender: UIButton) {
        delegate?.categorySetSelected(sender: self)
    }
}

protocol CategorySelectDelegate {
    func categorySetSelected(sender: CategoryCell)
}

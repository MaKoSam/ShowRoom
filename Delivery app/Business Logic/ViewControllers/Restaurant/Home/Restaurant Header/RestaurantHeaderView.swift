//
//  RestaurantHeaderView.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 16/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class RestaurantHeaderView: UIView {
    //MARK: - Subviews
    var restaurantHeadlineView = RestaurantView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 700.0))
    var breakLine = UIView()
    var categoryLabel = UILabel()
    var categorySelectionView = UICollectionView(frame: CGRect(x: 0.0, y: 720, width: UIScreen.main.bounds.width, height: 50.0), collectionViewLayout: UICollectionViewFlowLayout());
    
    //MARK: - Properties
    var categories = [FoodCategory]()
    var delegate: MenuNavigateCategoryDelegate?
    
    init() {
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        restaurantHeadlineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(restaurantHeadlineView)
        
        breakLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(breakLine)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(categoryLabel)
        
        categorySelectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(categorySelectionView)
    }
    
    private func configureConstraints() {
        restaurantHeadlineView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        restaurantHeadlineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        restaurantHeadlineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        restaurantHeadlineView.heightAnchor.constraint(greaterThanOrEqualToConstant: 700.0).isActive = true
        
        breakLine.topAnchor.constraint(equalTo: restaurantHeadlineView.bottomAnchor, constant: 5.0).isActive = true
        breakLine.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        breakLine.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        breakLine.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: breakLine.bottomAnchor, constant: 16.0).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        categorySelectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10.0).isActive = true
        categorySelectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        categorySelectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        categorySelectionView.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
    }
    
    private func configureViews() {
        breakLine.backgroundColor = Session.shared.viewSettings.secondColor
        
        categoryLabel.text = "Категории Блюд"
        categoryLabel.textColor = Session.shared.viewSettings.backgroundColor
        categoryLabel.adjustsFontSizeToFitWidth = true
        categoryLabel.font = UIFont(name: "Rockwell-Bold", size: 17.0)
        categoryLabel.addCharacterSpacing(kernValue: 1.0)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 150, height: 50.0)
        layout.minimumInteritemSpacing = 10.0
        layout.scrollDirection = .horizontal
        
        categorySelectionView.collectionViewLayout = layout
        categorySelectionView.backgroundColor = UIColor.white
        
        categorySelectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "category")
        categorySelectionView.dataSource = self
    }
}

extension RestaurantHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newCell: CategoryCell = categorySelectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! CategoryCell
        newCell.categoryButton.setTitle(categories[indexPath.row].description, for: .normal)
        newCell.delegate = self
        return newCell
    }
}

extension RestaurantHeaderView: CategorySelectDelegate {
    func categorySetSelected(sender: CategoryCell) {
        if let categoryID = categorySelectionView.indexPath(for: sender) {
            delegate?.navigateToCategory(categoryID.row)
        }
    }
}

protocol MenuNavigateCategoryDelegate {
    func navigateToCategory(_ categoryID: Int)
}

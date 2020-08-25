//
//  FeaturedView.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 05/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class FeaturedView: UIView {
    //MARK: - Subviews
    var featuredLabel = UILabel()
//    var featuredDetailLabel = UILabel()
    var featuredCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK: - Properties
    var featuredItems = [FoodItem]()
    var imageManager = ImageManager(container: UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout()))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureConstraints()
        configureViews()
        configureFeaturedCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        featuredLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(featuredLabel)
        
//        featuredDetailLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(featuredDetailLabel)
        
        featuredCollection.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(featuredCollection)
    }
    
    private func configureViews() {
        self.backgroundColor = UIColor.white
        
        featuredLabel.textColor = Session.shared.viewSettings.backgroundColor
        featuredLabel.adjustsFontSizeToFitWidth = true
        featuredLabel.font = UIFont(name: "Rockwell-Bold", size: 17.0)
        featuredLabel.addCharacterSpacing(kernValue: 1.0)
        
//        featuredDetailLabel.adjustsFontSizeToFitWidth = true
//        featuredDetailLabel.textColor = Session.shared.viewSettings.fourthColor
//        featuredDetailLabel.font = UIFont(name: "Rockwell-Bold", size: 17.0)
//        featuredDetailLabel.addCharacterSpacing(kernValue: 1.0)
    }
    
    private func configureConstraints() {
        featuredLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
        featuredLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        featuredLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        featuredLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
//        featuredDetailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0).isActive = true
//        featuredDetailLabel.leadingAnchor.constraint(equalTo: featuredLabel.trailingAnchor, constant: 5.0).isActive = true
//        featuredDetailLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        featuredCollection.topAnchor.constraint(equalTo: featuredLabel.bottomAnchor, constant: 15.0).isActive = true
        featuredCollection.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0.0).isActive = true
        featuredCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0.0).isActive = true
        featuredCollection.heightAnchor.constraint(greaterThanOrEqualToConstant: 280.0).isActive = true
    }
    
    private func configureFeaturedCollection() {
        let category = Session.shared.restaurantManager.categoryManager.getWith(name: "featured")
        featuredItems = Session.shared.restaurantManager.foodManager.getWith(categories: category)
        
        if let featuredCategory = category.first {
            featuredLabel.text = featuredCategory.description
        }
//        featuredDetailLabel.text = "\(featuredItems.count)"
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 370.0, height: 280.0)
        layout.scrollDirection = .horizontal
        featuredCollection.collectionViewLayout = layout
        featuredCollection.backgroundColor = UIColor.white
        featuredCollection.showsHorizontalScrollIndicator = false
        featuredCollection.showsVerticalScrollIndicator = false
        featuredCollection.register(FeaturedCell.self, forCellWithReuseIdentifier: "featuredItem")
        featuredCollection.dataSource = self
        imageManager = ImageManager(container: featuredCollection)
    }
}

extension FeaturedView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newCell: FeaturedCell = featuredCollection.dequeueReusableCell(withReuseIdentifier: "featuredItem", for: indexPath) as! FeaturedCell
        newCell.name.text = featuredItems[indexPath.row].name
        newCell.price.text = "\(featuredItems[indexPath.row].price)0 рублей"
        if let imageURL = featuredItems[indexPath.row].image {
            newCell.image.image = imageManager.image(atIndexPath: indexPath, byURL: imageURL)
        }
        newCell.layoutSubviews()
        return newCell
    }
}

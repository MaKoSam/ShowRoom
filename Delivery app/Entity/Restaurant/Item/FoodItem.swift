//
//  FoodItem.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 04/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class FoodItem {
    var id: Int
    var name: String
    var price: Double
    var description: String?
    var category: [FoodCategory]
    var image: String?
    
    init(id: Int, name: String, price: Double, description: String? = nil, category: [FoodCategory] = [], image: String? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.category = category
        self.image = image
    }
}

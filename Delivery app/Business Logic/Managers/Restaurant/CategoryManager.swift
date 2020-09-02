//
//  CategoryManager.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 07/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

class CategoryManager {
    private var categories = [FoodCategory]()
    
    func configureCategories(completionHandler: @escaping () -> Void) {
        getCategories {
            completionHandler()
        }
    }
    
    private func getCategories(completionHandler: @escaping () -> Void) {
        let items = Session.shared.restaurantManager.foodManager.getAll()
        for item in items {
            for category in item.category {
                add(category)
            }
        }
        completionHandler()
    }
    
    private func add(_ category: FoodCategory) {
        for existingCategory in categories {
            if existingCategory.id == category.id {
                return
            }
        }
        categories.append(category)
    }
}

extension CategoryManager {
    func getAll() -> [FoodCategory] {
        var returnCategories = [FoodCategory]()
        for category in categories {
            if category.name.hashValue != "featured".hashValue && category.name.hashValue != "meat".hashValue && category.name.hashValue != "fish".hashValue {
                returnCategories.append(category)
            }
        }
        return returnCategories
    }
    
    func getWith(name: String) -> [FoodCategory] {
        var returnCategories = [FoodCategory]()
        for category in categories {
            if category.description.lowercased().contains(name.lowercased()) ||
                category.name.lowercased().contains(name.lowercased()) {
                returnCategories.append(category)
            }
        }
        return returnCategories
    }
}

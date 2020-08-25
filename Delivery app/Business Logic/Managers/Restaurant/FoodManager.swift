//
//  FoodManager.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 05/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class FoodManager {
    private var foodItems = [FoodItem]()
    
    func configureItems(completionHandler: @escaping () -> Void) {
        getFoodItemsFromWeb {
            completionHandler()
        }
    }
    
    private func getFoodItemsFromWeb(completionHandler: @escaping () -> Void) {
        let requester = RestaurantNetworkRequest()
        requester.getFoodItems() { items in
            self.foodItems = items
            completionHandler()
        }
    }
}

extension FoodManager {
    func getAll() -> [FoodItem] {
        return self.foodItems
    }
    
    func getWith(categories: [FoodCategory]) -> [FoodItem] {
        var returnItems = [FoodItem]()
        for item in foodItems {
            for category in categories {
                for itemCategory in item.category {
                    if itemCategory.id == category.id {
                        returnItems.append(item)
                    }
                }
            }
        }
        return returnItems
    }
    
    func getWith(name: String) -> [FoodItem] {
        var returnItems = [FoodItem]()
        for item in foodItems {
            if item.name.lowercased().contains(name.lowercased()) {
                returnItems.append(item)
            }
        }
        return returnItems
    }
    
    func getWith(id: Int) -> FoodItem? {
        for item in foodItems {
            if item.id == id {
                return item
            }
        }
        return nil
    }
}

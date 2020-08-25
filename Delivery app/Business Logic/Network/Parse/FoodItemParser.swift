//
//  FoodItemParser.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 04/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class FoodItemParser {
    
    func parse(data: [String: Any]) -> [FoodItem] {
        var itemArray = [FoodItem]()
        guard let products = data["products"] as? [[String: Any]] else {
            print("Error parsing foodItems, stage 1")
            return []
        }
        for product in products {
            guard let info = product["info"] as? [String: Any],
                let pricing = product["pricing"] as? [String: Any] else {
                    print("Error parsing foodItems, stage 2")
                    return []
            }
            let productResponse = FoodItemResponse(info: info, pricing: pricing)
            if let item = parseItem(from: productResponse) {
                itemArray.append(item)
            }
        }
        
        return itemArray
    }
    
    private func parseItem(from response: FoodItemResponse) -> FoodItem? {
        guard let id = response.info["id"] as? Int,
            let name = response.info["title"] as? String,
            let amount = response.pricing["amount"] as? String,
            let price = Double(amount) else {
                print("Error parsing foodItems, stage 3")
                return nil
        }
        let foodItem = FoodItem(id: id, name: name, price: price)
        
        if let description = response.info["content"] as? String {
            foodItem.description = description
        }
        
        if let tags = response.info["tags"] as? [[String: Any]] {
            let categoryParser = CategoryParser()
            foodItem.category = categoryParser.parseTags(from: tags)
        }
        
        if let image = response.info["thumbnail"] as? String {
            foodItem.image = image
        }
        return foodItem
    }
}

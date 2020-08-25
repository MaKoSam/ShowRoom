//
//  CartManager.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 11/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class CartManager {
    private var items = [Int: Int]()
    private var detailItems = [FoodItem]()
    
    func addItem(id: Int) -> Int {
        if let existing = items[id] {
            items.updateValue(existing + 1, forKey: id)
            return existing + 1
        } else {
            if let newDetailItem = Session.shared.restaurantManager.foodManager.getWith(id: id) {
                detailItems.append(newDetailItem)
            }
            items.updateValue(1, forKey: id)
            return 1
        }
    }
    
    func deleteItem(id: Int) -> Int {
        if let existing = items[id] {
            items.updateValue(existing - 1, forKey: id)
            if existing - 1 <= 0 {
                items.removeValue(forKey: id)
                for index in 0...detailItems.count {
                    if detailItems[index].id == id {
                        detailItems.remove(at: index)
                        return 0
                    }
                }
                return 0
            }
            return existing - 1
        }
        return 0
    }
    
    func itemsInCart() -> Int {
        return detailItems.count
    }
    
    func isInCart(id: Int) -> Int? {
        guard let existing = items[id] else {
            return nil
        }
        return existing
    }
    
    func returnDetailItems() -> [FoodItem] {
        return detailItems
    }
    
    func returnItems() -> [Int: Int] {
        return items
    }
    
    func clearCart() {
        self.items.removeAll()
        self.detailItems.removeAll()
    }
}

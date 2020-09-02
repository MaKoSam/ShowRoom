//
//  RestaurantManager.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 04/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class RestaurantManager {
    let foodManager = FoodManager()
    let categoryManager = CategoryManager()
    let cartManager = CartManager()
    
    func configureRestaurant(completionHandler: @escaping () -> Void) {
        configureFromWeb {
            completionHandler()
        }
    }
    
    private func configureFromCache() {
        
    }
    
    private func configureFromWeb(completionHandler: @escaping () -> Void) {
        DispatchQueue.global(qos: .default).async {
            self.foodManager.configureItems {
                self.categoryManager.configureCategories {
                    completionHandler()
                }
            }
        }
    }
}

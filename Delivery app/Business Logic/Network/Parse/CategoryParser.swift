//
//  CategoryParser.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 07/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class CategoryParser {
    func parseTags(from tags: [[String:Any]]) -> [FoodCategory] {
        var returnCategory = [FoodCategory]()
        for tag in tags {
            if let category = parseCategory(from: tag) {
                returnCategory.append(category)
            }
        }
        return returnCategory
    }
    
    private func parseCategory(from dictionaty: [String: Any]) -> FoodCategory? {
        guard let id = dictionaty["term_id"] as? Int,
            let name = dictionaty["name"] as? String,
            let description = dictionaty["description"] as? String else {
                print("Error parsing foodCategories")
                return nil
        }
        let category = FoodCategory(id: id, name: name, description: description)
        return category
    }
}

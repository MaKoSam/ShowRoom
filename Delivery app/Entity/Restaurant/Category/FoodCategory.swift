//
//  FoodCategory.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 07/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class FoodCategory {
    var id: Int
    var name: String
    var description: String
    
    init(id: Int = 0, name: String = "", description: String = "") {
        self.id = id
        self.name = name
        self.description = description
    }
}

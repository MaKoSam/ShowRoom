//
//  FoodItemResponse.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 07/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class FoodItemResponse {
    var info: [String: Any]
    var pricing: [String: Any]
    
    init(info: [String: Any], pricing: [String: Any]) {
        self.info = info
        self.pricing = pricing
    }
}

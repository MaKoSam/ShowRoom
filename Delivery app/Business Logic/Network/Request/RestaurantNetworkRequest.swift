//
//  database.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 04/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit
import Alamofire

final class RestaurantNetworkRequest {
    func getFoodItems(completionHandler: @escaping ([FoodItem]) -> Void) {
        let foodItemsURL = "https://www.ohotnichi-sezoni.com/wp-json/myplugin/v1/api/restaurant/get/fooditem"
        guard let url = URL(string: foodItemsURL) else {
            return
        }
        let request = AF.request(url, method: .post)
        request.responseJSON() { response in
            if let error = response.error {
                print(error)
            } else if let data = response.data {
                do {
                    let json: [String: Any]! = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                    let parser = FoodItemParser()
                    let items = parser.parse(data: json)
                    completionHandler(items)
                } catch {
                    print(error)
                }
            }
        }
    }
}

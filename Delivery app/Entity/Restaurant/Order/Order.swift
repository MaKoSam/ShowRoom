//
//  Order.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 25/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class Order {
    var id: Int?
    
    var name: String
    var address: String
    var phone: String
    var email: String
    
    var cartItems: [FoodItem]
    var quantity: [Int : Int]
    
    var deliveryFee: Double = 0.0
    var totalPrice: Double = 0.0
    
    init(id: Int? = nil, user: User, cart: [FoodItem], quantity: [Int : Int]) {
        self.id = id
        self.name = user.name
        self.phone = user.phone
        self.email = user.email
        self.address = user.address
        
        self.cartItems = cart
        self.quantity = quantity
        
        self.totalPrice = self.calculateTotalPrice()
        self.deliveryFee = self.calculateDeliveryFee()
    }
    
    private func calculateDeliveryFee() -> Double {
        if self.totalPrice < 2000.0 {
            return 150.0
        }
        return 0.0
    }
    
    private func calculateTotalPrice() -> Double {
        var totalPrice = 0.0
        for item in cartItems {
            if let quantity = quantity[item.id] {
                totalPrice += Double(quantity) * item.price
            }
        }
        return totalPrice
    }
}

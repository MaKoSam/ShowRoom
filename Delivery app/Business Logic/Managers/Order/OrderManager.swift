//
//  OrderManager.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 25/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

enum OrderErrors {
    case noUser
    case cartEmpty
    case notWorkingHours
    case serverError
}

final class OrderManager {
    private lazy var order: Order? = nil
    
    func getOrderInfo() -> Order? {
        return self.order
    }
    
    func clearOrder() {
        self.order = nil
    }
    
    func createOrder(completionHandler: @escaping (Error?, OrderErrors?) -> Void) {
        guard let user = Session.shared.activeUser else {
            completionHandler(nil, .noUser)
            return
        }
        let cartItems = Session.shared.restaurantManager.cartManager.returnDetailItems()
        let quantity = Session.shared.restaurantManager.cartManager.returnItems()
        
        if cartItems.count == 0 || quantity.count == 0 {
            completionHandler(nil, .cartEmpty)
            return
        }
        
        let server = ServerNetworkManager()
        
        server.establishConnection() { connectionStatus in
            switch connectionStatus {
            case .online:
                self.order = Order(user: user, cart: cartItems, quantity: quantity)
                completionHandler(nil, nil)
            case .offline:
                completionHandler(nil, .serverError)
            case .nightMode:
                completionHandler(nil, .notWorkingHours)
            }
        }
    }
}

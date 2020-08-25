//
//  CheckoutManager.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 26/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class CheckoutManager {
    func checkout(order: Order?, completionHandler: @escaping(Bool) -> Void) {
         let server = ServerNetworkManager()
         server.establishConnection() { connectionStatus in
             switch connectionStatus {
             case .online:
                 if let order = order {
                     let orderTaker = OrderSaver()
                     orderTaker.saveOrder(order: order) { completion in
                         completionHandler(completion)
                         return
                     }
                 }
             case .offline:
                 completionHandler(false)
             case .nightMode:
                 completionHandler(false)
             }
         }
     }
    
    private func prepareForNext() {
        Session.shared.restaurantManager.cartManager.clearCart()
        Session.shared.orderManager.clearOrder()
    }
}

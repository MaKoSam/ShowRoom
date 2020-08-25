//
//  OrderSaver.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 25/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseFirestore

final class OrderSaver {
    let database = Firestore.firestore()
    
    func saveOrder(order: Order, completionHadler: @escaping(Bool) -> Void) {
        saveToDataBase(order: order)
        completionHadler(true)
    }
    
    private func saveToDataBase(order: Order) {
        guard let user = Session.shared.activeUser else {
            return
        }
        var dictionary = [String : Int]()
        
        for items in order.quantity {
            dictionary.updateValue(items.value, forKey: "\(items.key)")
        }
        
        self.database.collection("order_history").addDocument(data: [
            "user_id": user.id,
            "address": order.address,
            "cart": dictionary,
            "delivery": order.deliveryFee,
            "total": order.totalPrice,
            "status": "pending"
        ])
    }
    
    private func clearOrder() {
        
    }
}

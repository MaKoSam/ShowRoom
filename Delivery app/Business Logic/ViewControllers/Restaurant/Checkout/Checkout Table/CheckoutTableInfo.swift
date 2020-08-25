//
//  CheckoutTableInfo.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 25/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Foundation

final class CheckoutTableInfo {
    
    let numberOfSections = 7
    let nameOfSection = ["Ваш Заказ", nil, "Адрес Доставки", "Ваши Контакты", "Комментарий", "Способ оплаты", nil]
    
    var numberOfRowsInSection = [0, 2, 1, 2, 1, 1, 1]
    
    let totalPriceSectin = ["Доставка:", "Итог:"]
    let addressSection = ["Ваш адрес"]
    let contactsSection = ["Ваше имя", "Ваш телефон"]
    let commentSection = ["Ваш комментарий"]
    
}

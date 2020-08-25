//
//  OrderConfirmationController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 21/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class OrderConfirmationController: UIViewController {
    //MARK: - Subviews
    var headline = UILabel()
    
    var backButtonView = UIImageView()
    var backButton = UIButton()
    
    var orderTable = UITableView()
    
    //MARK: - Properties
    var constraints = [NSLayoutConstraint]()
    
    var orderManager = CheckoutTableInfo()
    var order: Order?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLayoutConstraint.activate(constraints)
        order = Session.shared.orderManager.getOrderInfo()
        orderManager.numberOfRowsInSection[0] = order?.cartItems.count ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func navigateBack(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension OrderConfirmationController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return orderManager.nameOfSection[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50.0
        case 1:
            return 50.0
        default:
            return 60.0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard order != nil else {
            return 0
        }
        return orderManager.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard order != nil else {
            return 0
        }
        return orderManager.numberOfRowsInSection[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let order = order else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case 0:
            let newCell: OrderItemCell = orderTable.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! OrderItemCell
            if let itemQuantity = order.quantity[order.cartItems[indexPath.row].id] {
                newCell.itemName.text = "\(itemQuantity) X \(order.cartItems[indexPath.row].name)"
                newCell.itemPrice.text = "\(order.cartItems[indexPath.row].price * Double(itemQuantity))0 ₽"
            } else {
                newCell.itemName.text = "1 X \(order.cartItems[indexPath.row].name)"
                newCell.itemPrice.text = "\(order.cartItems[indexPath.row].price)0 ₽"
            }
            return newCell
        case 1:
            let newCell: OrderItemCell = orderTable.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! OrderItemCell
            newCell.itemName.text = orderManager.totalPriceSectin[indexPath.row]
            if indexPath.row == 0 {
                newCell.itemPrice.text = "\(order.deliveryFee)0 ₽"
            } else {
                newCell.itemPrice.text = "\(order.totalPrice)0 ₽"
            }
            return newCell
        case 2:
            let newCell: OrderDetailCell = orderTable.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! OrderDetailCell
            newCell.name.text = orderManager.addressSection[indexPath.row]
            newCell.detailField.text = order.address
            newCell.delegate = self
            return newCell
        case 3:
            let newCell: OrderDetailCell = orderTable.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! OrderDetailCell
            newCell.name.text = orderManager.contactsSection[indexPath.row]
            if indexPath.row == 0 {
                newCell.detailField.text = order.name
            } else if indexPath.row == 1 {
                newCell.detailField.text = order.phone
            }
            newCell.delegate = self
            return newCell
        case 4:
            let newCell: OrderDetailCell = orderTable.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! OrderDetailCell
            newCell.name.text = orderManager.commentSection[indexPath.row]
            newCell.detailField.placeholder = "Ваш комментарий"
            newCell.delegate = self
            return newCell
        case 5:
            let newCell: OrderButtonCell = orderTable.dequeueReusableCell(withIdentifier: "button", for: indexPath) as! OrderButtonCell
            newCell.button.setTitle("Наличными курьеру", for: .normal)
            newCell.delegate = self
            return newCell
        case 6:
            let newCell: OrderButtonCell = orderTable.dequeueReusableCell(withIdentifier: "button", for: indexPath) as! OrderButtonCell
            newCell.button.setTitle("Оформить Заказ", for: .normal)
            newCell.delegate = self
            return newCell
        default:
            return UITableViewCell()
        }
    }
}

extension OrderConfirmationController: OrderDetailEditorDelegate {
    func detailUpdated(sender: OrderDetailCell) {
        guard let indexPath = orderTable.indexPath(for: sender) else {
            return
        }
        switch indexPath.section {
        case 2:
            print("edited address")
        case 3:
            switch indexPath.row {
            case 0:
                print("editted name")
            case 1:
                print("editted phone")
            default:
                print("errod editting personal data")
            }
        case 4:
            print("added comment")
        default:
            print("error editting")
        }
    }
}

extension OrderConfirmationController: OrderButtonActionDelegate {
    func buttonPressed(sender: OrderButtonCell) {
        guard let indexPath = orderTable.indexPath(for: sender) else {
            return
        }
        switch indexPath.section {
        case 5:
            print("pressed payment type")
        case 6:
            print("order placed")
            /*Session.shared.orderManager.completeOrder() { isCompleted in
                if isCompleted {
                    AppDelegate.shared.rootViewController.navigateToShopBranch()
                } else {
                    print("error placing order")
                }
            }*/
        default:
            print("pressed error")
        }
    }
}

//
//  CartViewController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 14/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

enum CartState {
    case empty
    case full
}

class CartViewController: UIViewController {
    //MARK: - Subviews
    var headline = UILabel()
    
    var backButtonView = UIImageView()
    var backButton = UIButton()
    
    var emptyCart = EmptyCartView(frame: .zero)
    var cartTable = UITableView()
    var checkoutButton = UIButton()
    
    //MARK: - Properties
    var cartState: CartState = .empty
    var rawItemID = [Int: Int]()
    var cartItems = [FoodItem]()
    var imageManager = ImageManager(container: UITableView())
    var itemsInCart: Int = 0 {
        willSet {
            if newValue % 10 == 1 && newValue != 11 {
                headline.text = "В корзине \(newValue) блюдо"
            } else {
                headline.text = "В корзине \(newValue) блюд"
            }
        }
    }
    
    //MARK: - Constraints
    var constraints = [NSLayoutConstraint]()
    var tableConstraint = [NSLayoutConstraint]()
    var emptyConstraint = [NSLayoutConstraint]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NSLayoutConstraint.activate(constraints)
        itemsInCart = Session.shared.restaurantManager.cartManager.itemsInCart()
        if itemsInCart == 0 {
            cartState = .empty
            
            self.view.addSubview(emptyCart)
            NSLayoutConstraint.activate(emptyConstraint)
            
            checkoutButton.setTitle("Вернуться к Меню", for: .normal)
        } else {
            cartState = .full
            
            self.view.addSubview(cartTable)
            NSLayoutConstraint.activate(tableConstraint)
            
            cartItems = Session.shared.restaurantManager.cartManager.returnDetailItems()
            rawItemID = Session.shared.restaurantManager.cartManager.returnItems()
            
            checkoutButton.setTitle("Оформить Заказ", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell: CartCell = cartTable.dequeueReusableCell(withIdentifier: "cart", for: indexPath) as! CartCell
        return newCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? CartCell {
            cell.name.text = cartItems[indexPath.row].name
            cell.id = cartItems[indexPath.row].id
            cell.delegate = self
            if let quantity = rawItemID[cell.id] {
                cell.quantity.text = "\(quantity)"
                cell.price.text = "\(Double(quantity) * cartItems[indexPath.row].price)0 ₽"
            }
            if let imageURL = cartItems[indexPath.row].image {
                cell.foodImage.image = imageManager.image(atIndexPath: indexPath, byURL: imageURL)
            }
        }
    }
}

extension CartViewController: CartItemDelegate {
    func addItem(_ sender: CartCell, item id: Int) {
        guard let indexPath = cartTable.indexPath(for: sender) else {
            return
        }
        let quantityNumber = Session.shared.restaurantManager.cartManager.addItem(id: id)
        sender.quantity.text = "\(quantityNumber)"
        sender.price.text = "\(Double(quantityNumber) * cartItems[indexPath.row].price)0 ₽"
    }
    
    func removeItem(_ sender: CartCell, item id: Int) {
        guard let indexPath = cartTable.indexPath(for: sender) else {
            return
        }
        let quantityNumber = Session.shared.restaurantManager.cartManager.deleteItem(id: id)
        if quantityNumber <= 0 {
            cartItems = Session.shared.restaurantManager.cartManager.returnDetailItems()
            rawItemID = Session.shared.restaurantManager.cartManager.returnItems()
            cartTable.deleteRows(at: [indexPath], with: .fade)
        } else {
            sender.quantity.text = "\(quantityNumber)"
            sender.price.text = "\(Double(quantityNumber) * cartItems[indexPath.row].price)0 ₽"
        }
    }
}

extension CartViewController {
    @objc func checkoutPressed() {
        switch cartState {
        case .empty:
            self.navigationController?.popViewController(animated: true)
        case .full:
            Session.shared.orderManager.createOrder() { (error, type) in
                if let errorType = type {
                    switch errorType {
                    case .cartEmpty:
                        print("cartEmpty")
                    case .noUser:
                        print("noUsr")
                    case .notWorkingHours:
                        print("comelater")
                    case .serverError:
                        print("serveroffline")
                    }
                } else {
                    let builder = OrderConfirmationBuilder()
                    self.navigationController?.pushViewController(builder.buildController(), animated: true)
                }
            }
        }
    }
    
    @objc func navigateBack(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func presentError(error message: String?) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}

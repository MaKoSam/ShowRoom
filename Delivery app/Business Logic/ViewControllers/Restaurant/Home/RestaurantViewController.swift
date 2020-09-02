//
//  ViewController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 07/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController {
    //MARK: - Views
    var controlBar = ControlBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 130))
    var tableHeader = RestaurantHeaderView(frame: .zero)
    var tableHeaderSize = CGSize(width: UIScreen.main.bounds.width, height: 820.0)
    var menuTable = UITableView(frame: .zero, style: .grouped)
    var cartButton = UIButton(frame: .zero)
    
    //MARK: - Properties
    var categories = [FoodCategory]()
    var categoryMenu = [FoodItem]()
    
    var imageManager: ImageManager?
    var constraints = [NSLayoutConstraint]()
    var cartButtonConstraints = [NSLayoutConstraint]()
    var cartItemsCount = 0
    
    //MARK: - Detail Card
    var detailCard: FoodItemDetailCardView!
    var detailCardHeight = CGFloat()
    var hiddenFrame = CGRect()
    var presentedFrame = CGRect()
    var transparentView = UIView(frame: .zero)
    private var viewTranslation = CGPoint(x: 0.0, y: 0.0)
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NSLayoutConstraint.activate(constraints)
        categories = Session.shared.restaurantManager.categoryManager.getAll()
        tableHeader.categories = categories
        addToCart(FoodCell())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Extension: UITableView Delegate, DataSource
extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categoryMeny = Session.shared.restaurantManager.foodManager.getWith(categories: [categories[section]])
        return categoryMeny.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = MenuSectionHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50))
        header.name.text = categories[section].description
        return header
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell: FoodCell = menuTable.dequeueReusableCell(withIdentifier: "food", for: indexPath) as! FoodCell
        newCell.delegate = self
        return newCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as! FoodCell
        var categoryMeny = [FoodItem]()
        categoryMeny = Session.shared.restaurantManager.foodManager.getWith(categories: [categories[indexPath.section]])
        cell.itemId = categoryMeny[indexPath.row].id
        cell.name.text = categoryMeny[indexPath.row].name
        cell.name.sizeToFit()
        cell.price.text = "\(categoryMeny[indexPath.row].price)0 ₽"
        cell.price.sizeToFit()
        if let imageURL = categoryMeny[indexPath.row].image {
            let foodImage = imageManager?.image(atIndexPath: indexPath, byURL: imageURL)
            cell.foodImage.image = foodImage
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryMenu = Session.shared.restaurantManager.foodManager.getWith(categories: [categories[indexPath.section]])
        let item = categoryMenu[indexPath.row]
        detailCard.foodItem = item
        if let imageURL = item.image {
            detailCard.foodImage.image = imageManager?.image(atIndexPath: indexPath, byURL: imageURL)
        }
        self.view.addSubview(transparentView)
        self.view.addSubview(detailCard)
        UIView.animate(withDuration: 0.7) {
            self.transparentView.alpha = 0.9
            self.detailCard.frame = self.presentedFrame
        }
    }
}

extension RestaurantViewController: MenuNavigateCategoryDelegate {
    func navigateToCategory(_ categoryID: Int) {
        let indexPath = IndexPath(row: 0, section: categoryID)
        self.menuTable.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension RestaurantViewController {
    @objc func panOnDetailCard(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .changed:
            viewTranslation = recognizer.translation(in: view)
            if viewTranslation.y > 0 {
                UIView.animate(withDuration: 0.5) {
                    self.detailCard.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
                }
            }
        case .ended:
            if viewTranslation.y < 50 {
                UIView.animate(withDuration: 0.5) {
                    self.detailCard.frame = self.presentedFrame
                }
            } else {
                removeDetailCard()
            }
        default:
            break
        }
    }
    
    private func removeDetailCard() {
        UIView.animate(withDuration: 1.0, animations: {
            self.transparentView.alpha = 0.0
            self.detailCard.frame = self.hiddenFrame
        }, completion: { ended in
            if ended {
                self.transparentView.removeFromSuperview()
                self.detailCard.removeFromSuperview()
                self.detailCard.foodItem = nil
                self.detailCard.foodImage.image = nil
                self.detailCard.shadowView.alpha = 0.0
                self.detailCard.qunatityNumber = 0;
                self.detailCard.cartQuantity.text = nil
            }
        })
    }
}

extension RestaurantViewController: PresentCartDelegate {
    func addToCart(_ tappedCel: FoodCell) {
        cartItemsCount = Session.shared.restaurantManager.cartManager.itemsInCart()
        if cartItemsCount == 1 {
            self.view.addSubview(cartButton)
            NSLayoutConstraint.activate(cartButtonConstraints)
        }
    }
    
    func removeFromCart(_ tappedCell: FoodCell) {
        cartItemsCount = Session.shared.restaurantManager.cartManager.itemsInCart()
        if cartItemsCount == 0 {
            NSLayoutConstraint.deactivate(cartButtonConstraints)
            self.cartButton.removeFromSuperview()
        }
    }
    
    @objc func navigateToCart(sender: UIButton) {
        let controllerBuilder = CartControllerBuilder()
        let new = controllerBuilder.buildController()
        self.navigationController?.pushViewController(new, animated: true)
    }
}

extension RestaurantViewController: BarDelegate {
    func menuPressed() {
        let controllerBuilder = MenuBuilder()
        let new = controllerBuilder.buildController()
        self.navigationController?.pushViewController(new, animated: true)
    }
    
    func carPressed() {
        let controllerBuilder = CartControllerBuilder()
        let new = controllerBuilder.buildController()
        self.navigationController?.pushViewController(new, animated: true)
    }
}

extension RestaurantViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > 750 && scrollView.contentOffset.y < 800) {
            UIView.animate(withDuration: 1.0) {
                self.controlBar.backgroundView.alpha = 1.0
                self.controlBar.nameLabel.alpha = 1.0
                
                self.controlBar.menuView.backgroundColor = Session.shared.viewSettings.backgroundColor
                self.controlBar.cartView.backgroundColor = Session.shared.viewSettings.backgroundColor
            }
        } else
            if (scrollView.contentOffset.y < 750) {
                UIView.animate(withDuration: 1.0) {
                    self.controlBar.backgroundView.alpha = 0.0
                    self.controlBar.nameLabel.alpha = 0.0
                    
                    self.controlBar.menuView.backgroundColor = .white
                    self.controlBar.cartView.backgroundColor = .white
                }
        }
    }
}

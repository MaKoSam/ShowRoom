//
//  MenuViewController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 21/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

enum AuthState {
    case signedIn
    case signedOut
}

class MenuViewController: UIViewController {
    //MARK: - Subviews
    let navigationView = NavigationView()
    let menuTable = MenuTableView()
    
    //MARK: - Properties
    var constraints = [NSLayoutConstraint]()
    private var currentAuthState: AuthState = .signedOut
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        NSLayoutConstraint.activate(constraints)
        
        if let _ = Session.shared.activeUser {
            currentAuthState = .signedIn
        } else {
            currentAuthState = .signedOut
        }
        menuTable.setAuthState(authState: currentAuthState)
        navigationView.presentTitle("menu".localized())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Menu Table Delegate
extension MenuViewController: MenuTableDelegate {
    func presentUserInfo() {
        let builder = MyInfoBuilder()
        self.navigationController?.pushViewController(builder.buildController(), animated: true)
    }
    
    func presentUserOrders() {
        AppDelegate.shared.rootViewController.navigateToLogOut()
    }
    
    func presentUserAddress() {
        print("user_address")
    }
    
    func presentDeliveryInfo() {
        self.navigationController?.pushViewController(DeliveryPriceController(), animated: true)
    }
    
    func presentCall() {
        guard let phoneCall = URL(string: "tel://+73242250828") else {
            return
        }
        UIApplication.shared.open(phoneCall, options: [:], completionHandler: nil)
    }
    
    func presentFeedback() {
        print("feedback form")
    }
    
    func presentAppInfo() {
        let new = WebViewController()
        new.urlRequest = "http://www.ohotnichi-sezoni.com/agreement/"
        new.controllerTitle = "Пользовательское соглашение"
        self.navigationController?.pushViewController(new, animated: true)
    }
    
    func presentAuth() {
        AppDelegate.shared.rootViewController.navigateToAuthorizationBranch()
    }
}

//MARK: - Delegate: Navigation View
extension MenuViewController: NavigationDelegate {
    func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

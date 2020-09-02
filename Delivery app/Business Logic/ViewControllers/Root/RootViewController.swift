//
//  RootViewController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 03/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    private var currentViewController: UIViewController
    private let internetConnection = NetworkConnection()
    
    init() {
        let controllerBuilder = LaunchControllerBuilder()
        currentViewController = controllerBuilder.buildController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addChild(currentViewController)
        currentViewController.view.frame = view.bounds
        view.addSubview(currentViewController.view)
        currentViewController.didMove(toParent: self)
        checkInternetConnection()
    }
    
    func checkInternetConnection() {
        internetConnection.isInternetConnected { isConnected in
            if isConnected {
                print("all ok")
            } else {
                DispatchQueue.main.async {
                    self.navigateToNoInternetPage()
                }
            }
        }
    }
    
    func navigateToNoInternetPage() {
        let newController = NoInternetController()
        
        addChild(newController)
        newController.view.frame = view.bounds
        view.addSubview(newController.view)
        newController.didMove(toParent: self)
        
        currentViewController.willMove(toParent: nil)
        currentViewController.view.removeFromSuperview()
        currentViewController.removeFromParent()
        
        currentViewController = newController
    }
    
    func navigateToAuthorizationBranch() {
        let controllerBuilder = AuthBuilder()
        let new = controllerBuilder.buildController()
        let newController = UINavigationController(rootViewController: new)
        animateFadeTransition(to: newController)
    }
    
    func navigateToShopBranch() {
        let controllerBuilder = RestaurantControllerBuilder()
        let new = controllerBuilder.buildController()
        let newController = UINavigationController(rootViewController: new)
        animateFadeTransition(to: newController)
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
       currentViewController.willMove(toParent: nil)
       addChild(new)
       
       transition(from: currentViewController, to: new, duration: 0.5, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
       }) { completed in
            self.currentViewController.removeFromParent()
            new.didMove(toParent: self)
            self.currentViewController = new
            completion?() 
       }
    }
    
    func navigateToLogOut() {
        Session.shared.userManager.logout()
        navigateToShopBranch()
    }
}

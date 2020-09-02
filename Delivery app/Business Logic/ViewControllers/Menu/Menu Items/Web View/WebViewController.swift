//
//  ContactsController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 22/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    //MARK: - Subview
    let navigationView = NavigationView()
    let headline = UILabel()
    let webView = WKWebView()
    
    //MARK: - Properties
    let viewSettings = Session.shared.viewSettings
    var urlRequest: String?
    var controllerTitle: String? {
        willSet {
            self.headline.text = newValue
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addViews()
        configureConstraints()
        configureViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let request = urlRequest, let url = URL(string: request) {
            webView.load(URLRequest(url: url))
        }
    }
    
    private func addViews() {
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(navigationView)
        
        headline.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headline)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.topAnchor,
                                                           constant: viewSettings.statusBarHeightMargine),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: viewSettings.navigationBarHeightMargine),
            
            headline.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            headline.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                         constant: viewSettings.conteinerSpaceConstant),
            headline.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                          constant: -viewSettings.conteinerSpaceConstant),
            headline.heightAnchor.constraint(equalToConstant: viewSettings.viewHeightConstant),
            
            webView.topAnchor.constraint(equalTo: headline.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func configureViews() {
        self.view.backgroundColor = .white
        
        navigationView.delegate = self
        
        headline.text = controllerTitle
        headline.textAlignment = .left
        headline.textColor = viewSettings.darkTextColor
        headline.font = viewSettings.headerFont
        headline.numberOfLines = 2
        headline.lineBreakMode = .byClipping
        headline.baselineAdjustment = .alignCenters
        
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
    }
}

//MARK: - Navigation Delegate
extension WebViewController: NavigationDelegate {
    func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - WebView Delegate
extension WebViewController: WKNavigationDelegate {
    
}

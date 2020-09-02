//
//  NavigationView.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 31/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class NavigationView: UIView {
    //MARK: - Subviews
    private let navigationButtonView = UIImageView()
    private let navigationButton = UIButton()
    private let title = UILabel()
    
    //MARK: - Properties
    private let viewSettings: ViewSettings
    
    //MARK: - Delegate
    var delegate: NavigationDelegate?
    
    init(){
        viewSettings = Session.shared.viewSettings
        super.init(frame: .zero)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    override init(frame: CGRect) {
        viewSettings = Session.shared.viewSettings
        super.init(frame: frame)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        viewSettings = Session.shared.viewSettings
        super.init(coder: coder)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    private func addViews() {
        title.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(title)
        
        navigationButtonView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(navigationButtonView)
        
        navigationButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(navigationButton)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            navigationButton.topAnchor.constraint(equalTo: self.topAnchor,
                                                  constant: viewSettings.statusBarHeightMargine),
            navigationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                      constant: viewSettings.conteinerSpaceConstant),
            navigationButton.heightAnchor.constraint(equalToConstant: viewSettings.navigationButtonHeightConstant),
            navigationButton.widthAnchor.constraint(equalToConstant: viewSettings.navigationButtonWidthConstant),
            
            navigationButtonView.centerXAnchor.constraint(equalTo: navigationButton.centerXAnchor),
            navigationButtonView.centerYAnchor.constraint(equalTo: navigationButton.centerYAnchor),
            navigationButtonView.heightAnchor.constraint(equalToConstant: viewSettings.navigationButtonHeightConstant / 2.0),
            navigationButtonView.widthAnchor.constraint(equalToConstant: viewSettings.navigationButtonWidthConstant / 2.0),
            
            title.centerYAnchor.constraint(equalTo: navigationButton.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                           constant: viewSettings.conteinerSpaceConstant),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                            constant: -viewSettings.conteinerSpaceConstant),
            title.heightAnchor.constraint(equalToConstant: viewSettings.viewHeightConstant)
        ])
    }
    
    private func configureViews() {
        self.backgroundColor = .white
        
        navigationButtonView.image = UIImage(named: "back.png")
        navigationButtonView.contentMode = .scaleToFill
        
        navigationButton.backgroundColor = viewSettings.darkBackgroundColor
        navigationButton.alpha = 0.2
        navigationButton.layer.cornerRadius = viewSettings.buttonCornerRadius
        navigationButton.addTarget(self, action: #selector(NavigationView.navigationButtonPressed(sender:)), for: .touchUpInside)
        
        title.alpha = 0.0
        title.backgroundColor = .white
        title.addCharacterSpacing(kernValue: 1.0)
        title.numberOfLines = 2
        title.lineBreakMode = .byWordWrapping
        title.textAlignment = .center
        title.textColor = viewSettings.darkTextColor
        title.font = viewSettings.contentFont
    }
    
    @objc func navigationButtonPressed(sender: UIButton) {
        delegate?.navigateBack()
    }
}

//MARK: - Navigation View Title Actions
extension NavigationView {
    func presentTitle(_ title: String) {
        self.title.text = title
        UIView.animate(withDuration: 0.5) {
            self.title.alpha = 1.0
        }
    }
    
    func hideTitle() {
        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.title.alpha = 0.0
        }, completion: { isCompleted in
            if isCompleted {
                self.title.text = nil
            }
        })
    }
}

//MARK: - Navigation Delegate
protocol NavigationDelegate {
    func navigateBack()
}

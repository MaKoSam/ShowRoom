//
//  MenuSectionHeaderView.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 12/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class MenuSectionHeaderView: UIView {
    //MARK: - Subviews
    let name = UILabel()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    private func addViews() {
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)
    }
    
    private func configureConstraints() {
        name.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        name.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        name.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    private func configureViews() {
        self.backgroundColor = .white
        
        name.backgroundColor = .white
        name.font = UIFont(name: "Rockwell-Bold", size: 20.0)
        name.textColor = Session.shared.viewSettings.backgroundColor
        name.addCharacterSpacing(kernValue: 1.0)
    }
    
}

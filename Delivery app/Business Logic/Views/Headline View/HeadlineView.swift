//
//  HeadlineView.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 01/06/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class HeadlineView: UIView {
    //MARK: - Subviews
    private let title = UILabel()
    
    //MARK: - Properties
    private let viewSettings: ViewSettings
    
    init() {
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
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: viewSettings.conteinerSpaceConstant),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -viewSettings.conteinerSpaceConstant),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0)
        ])
    }
    
    private func configureViews() {
        self.backgroundColor = .white
        
        title.backgroundColor = .white
        title.textAlignment = .left
        title.textColor = viewSettings.headerTextColor
        title.font = viewSettings.headerFont
        
        title.numberOfLines = 2
        title.lineBreakMode = .byWordWrapping
        title.addCharacterSpacing(kernValue: 1.0)
    }
    
    func setTitle(_ title: String) {
        self.title.text = title
    }
}

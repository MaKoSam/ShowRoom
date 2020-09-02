//
//  AuthDataCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 31/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class AuthDataCell: UITableViewCell {
    //MARK: - Subviews
    let shadowView = UIView()
    let title = UILabel()
    let textField = UITextField()
    
    //MARK: - Properties
    private let viewSettings: ViewSettings
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        viewSettings = Session.shared.viewSettings
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func addViews() {
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(shadowView)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textField)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                      constant: viewSettings.innerContainerSpaceConstant),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                          constant: viewSettings.conteinerSpaceConstant),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                           constant: -viewSettings.conteinerSpaceConstant),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                               constant: -viewSettings.innerContainerSpaceConstant),
            
            title.topAnchor.constraint(equalTo: shadowView.topAnchor,
                                       constant: viewSettings.innerContainerSpaceConstant),
            title.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor,
                                                           constant: viewSettings.conteinerSpaceConstant),
            title.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor,
                                                            constant: -viewSettings.conteinerSpaceConstant),
            title.heightAnchor.constraint(equalToConstant: 16.0),
               
            textField.topAnchor.constraint(equalTo: title.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor,
                                                           constant: viewSettings.conteinerSpaceConstant),
            textField.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor,
                                                            constant: -viewSettings.conteinerSpaceConstant),
            textField.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor,
                                                          constant: -viewSettings.innerContainerSpaceConstant)
        ])
    }
    
    private func configureViews() {
        contentView.backgroundColor = .white
        
        shadowView.alpha = 0.2
        shadowView.layer.cornerRadius = viewSettings.viewCornerRadius
        shadowView.backgroundColor = viewSettings.lightBackgroundColor
        
        title.addCharacterSpacing(kernValue: 1.0)
        title.textColor = viewSettings.darkTextColor
        title.font = viewSettings.smallContentFont
        
        textField.textColor = viewSettings.headerTextColor
        textField.font = viewSettings.contentFont
    }
}

//
//  MenuPersonalCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 02/06/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class MenuPersonalCell: UITableViewCell {
    //MARK: - Subviews
    let nameTitle = UILabel()
    let phoneTitle = UILabel()
    let button = UIButton()
    
    //MARK: - Properties
    private let viewSettings: ViewSettings
    
    //MARK: - Delegate
    var delegate: MenuPersonalCellDelegate?
    
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
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(nameTitle)
        
        phoneTitle.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(phoneTitle)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(button)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            nameTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                           constant: viewSettings.innerContainerSpaceConstant),
            nameTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                               constant: viewSettings.conteinerSpaceConstant),
            nameTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                               constant: -viewSettings.conteinerSpaceConstant),
            nameTitle.heightAnchor.constraint(equalToConstant: viewSettings.headerTitleHeightConstant),
            
            phoneTitle.topAnchor.constraint(equalTo: nameTitle.bottomAnchor,
                                            constant: viewSettings.innerContainerSpaceConstant),
            phoneTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                               constant: viewSettings.conteinerSpaceConstant),
            phoneTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                               constant: -viewSettings.conteinerSpaceConstant),
            phoneTitle.heightAnchor.constraint(equalToConstant: viewSettings.headerTitleHeightConstant / 2.0),
            
            button.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    private func configureViews() {
        self.contentView.backgroundColor = .white
        
        nameTitle.backgroundColor = .white
        nameTitle.font = viewSettings.headerFont
        nameTitle.textColor = viewSettings.headerTextColor
        nameTitle.addCharacterSpacing(kernValue: 1.0)
        
        phoneTitle.backgroundColor = .white
        phoneTitle.font = viewSettings.contentFont
        phoneTitle.textColor = viewSettings.headerTextColor
        phoneTitle.addCharacterSpacing()
        
        button.addTarget(self, action: #selector(MenuPersonalCell.buttonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIButton) {
        delegate?.navigateToPersonalInfo()
    }
}

//MARK: - Personal Cell Delegate
protocol MenuPersonalCellDelegate {
    func navigateToPersonalInfo()
}

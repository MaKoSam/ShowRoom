//
//  MenuItemCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 22/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    //MARK: - Subviews
    let title = UILabel()
    let itemImage = UIImageView()
    let button = UIButton()
    
    //MARK: - Properties
    let viewSettings: ViewSettings
    
    //MARK: - Delegate
    var delegate: MenuItemSelectDelegate?
    
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
    
    
    private func addViews() {
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(itemImage)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(title)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(button)
    }
    
    private func configureConstraints() {
        itemImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0).isActive = true
        itemImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0).isActive = true
        itemImage.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
        itemImage.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        
        title.centerYAnchor.constraint(equalTo: self.itemImage.centerYAnchor, constant: 5.0).isActive = true
        title.leadingAnchor.constraint(equalTo: self.itemImage.trailingAnchor, constant: 10.0).isActive = true
        title.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0).isActive = true
        title.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        button.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0).isActive = true
        button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0).isActive = true
        button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35.0).isActive = true
    }
    
    private func configureViews() {
        self.contentView.backgroundColor = .white
        
        itemImage.contentMode = .scaleAspectFit
        itemImage.backgroundColor = .white
        
        title.backgroundColor = .white
        title.addCharacterSpacing(kernValue: 1.0)
        title.font = viewSettings.contentFont
        title.textColor = viewSettings.darkTextColor
        
        button.addTarget(self, action: #selector(MenuItemCell.pressedSelect), for: .touchUpInside)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func pressedSelect() {
        delegate?.setSelectedItem(self)
    }

}

protocol MenuItemSelectDelegate {
    func setSelectedItem(_ sender: MenuItemCell)
}

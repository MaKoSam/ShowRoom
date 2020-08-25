//
//  MyInfoCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 22/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class MyInfoCell: UITableViewCell {
    //MARK: - Subviews
    let title = UILabel()
    let textField = UITextField()
    
    //MARK: - Properties
    let viewSettings: ViewSettings
    
    //MARK: - Delegate
    var delegate: EditInfoDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        viewSettings = Session.shared.viewSettings
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        title.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(title)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textField)
    }
    
    private func configureConstraints() {
        title.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5.0).isActive = true
        title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0).isActive = true
        title.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0).isActive = true
        title.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        
        textField.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 0.0).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16.0).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16.0).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    private func configureViews() {
        self.contentView.backgroundColor = .white
        title.addCharacterSpacing(kernValue: 1.0)
        title.font = viewSettings.smallContentFont
        title.textColor = viewSettings.darkTextColor
        title.backgroundColor = .white
        
        textField.textColor = viewSettings.headerTextColor
        textField.font = viewSettings.contentFont
        textField.addTarget(self, action: #selector(MyInfoCell.endedEditingInfo), for: .editingDidEnd)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func endedEditingInfo() {
        delegate?.endedEditing(sender: self)
    }
}

protocol EditInfoDelegate {
    func endedEditing(sender: MyInfoCell)
}

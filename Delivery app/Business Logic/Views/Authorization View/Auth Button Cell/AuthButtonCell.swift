//
//  AuthButtonCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 31/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class AuthButtonCell: UITableViewCell {
    //MARK: - Subview
    let button = UIButton()
    
    //MARK: - Properties
    private let viewSettings: ViewSettings
    
    //MARK: - Delegate
    var delegate: AuthButtonDelegate?
    
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
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                      constant: viewSettings.innerContainerSpaceConstant),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                          constant: viewSettings.conteinerSpaceConstant),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                           constant: -viewSettings.conteinerSpaceConstant),
            button.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func configureViews() {
        contentView.backgroundColor = .white
        
        button.backgroundColor = viewSettings.lightBackgroundColor
        button.setTitleColor(viewSettings.lightTextColor, for: .normal)
        button.titleLabel?.font = viewSettings.contentFont
        button.layer.cornerRadius = viewSettings.buttonCornerRadius
        button.addTarget(self, action: #selector(AuthButtonCell.buttonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIButton) {
        self.delegate?.authButtonPressed()
    }
}

protocol AuthButtonDelegate {
    func authButtonPressed()
}

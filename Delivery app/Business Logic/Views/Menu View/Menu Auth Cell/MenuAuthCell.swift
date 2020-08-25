//
//  MenuAuthCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 02/06/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class MenuAuthCell: UITableViewCell {
    //MARK: - Subviews
    let button = UIButton()
    
    //MARK: - Properties
    private let viewSettings: ViewSettings
    private let title = "sign_in_action".localized()
    
    //MARK: - Delegate
    var delegate: MenuAuthDelegate?
    
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
        self.contentView.addSubview(button)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                        constant: viewSettings.innerContainerSpaceConstant),
            button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,
                                            constant: viewSettings.conteinerSpaceConstant),
            button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,
                                             constant: -viewSettings.conteinerSpaceConstant),
            button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,
                                           constant: -viewSettings.innerContainerSpaceConstant)
        ])
    }
    
    private func configureViews() {
        button.layer.cornerRadius = viewSettings.buttonCornerRadius
        button.setTitle(title, for: .normal)
        button.setTitleColor(viewSettings.lightTextColor, for: .normal)
        button.backgroundColor = viewSettings.lightBackgroundColor
        button.addTarget(self, action: #selector(MenuAuthCell.buttonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc func buttonPressed(sender: UIButton) {
        delegate?.navigateToAuth()
    }
}

//MARK: - Menu Auth Delegate
protocol MenuAuthDelegate {
    func navigateToAuth()
}

//
//  OrderButtonCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 25/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class OrderButtonCell: UITableViewCell {
    //MARK: - Subviews
    let button = UIButton()
    
    //MARK: - Delegate
    var delegate: OrderButtonActionDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configureConstraints()
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func addViews() {
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0)
        ])
    }
    
    private func configureViews() {
        self.backgroundColor = .white
        
        button.backgroundColor = Session.shared.viewSettings.backgroundColor
        button.setTitleColor(Session.shared.viewSettings.fourthColor, for: .normal)
        button.layer.cornerRadius = 20.0
        button.addTarget(self, action: #selector(OrderButtonCell.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        delegate?.buttonPressed(sender: self)
    }

}

protocol OrderButtonActionDelegate {
    func buttonPressed(sender: OrderButtonCell)
}

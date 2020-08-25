//
//  OrderDetailCell.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 25/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class OrderDetailCell: UITableViewCell {
    //MARK: - Subviews
    let backView = UIView()
    let name = UILabel()
    let detailField = UITextField()
    
    //MARK: - Delegate
    var delegate: OrderDetailEditorDelegate?
    
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
        backView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(backView)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)
        
        detailField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(detailField)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
        	backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0),
        
        	name.topAnchor.constraint(equalTo: backView.topAnchor, constant: 5.0),
        	name.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10.0),
        	name.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10.0),
        	name.heightAnchor.constraint(equalToConstant: 15.0),
            
            detailField.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5.0),
            detailField.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 10.0),
            detailField.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10.0),
            detailField.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -5.0)
        ])
    }
    
    private func configureViews() {
        self.backgroundColor = .white
        
        backView.backgroundColor = Session.shared.viewSettings.backgroundColor
        backView.alpha = 0.2
        
        name.textAlignment = .left
        name.textColor = Session.shared.viewSettings.fourthColor
        name.font = UIFont(name: "Rockwell", size: 14.0)
        
        detailField.textColor = Session.shared.viewSettings.fourthColor
        detailField.font = UIFont(name: "Rockwell", size: 17.0)
        detailField.addTarget(self, action: #selector(OrderDetailCell.endedEditting), for: .editingDidEnd)
    }
    
    @objc func endedEditting() {
        delegate?.detailUpdated(sender: self)
    }

}

protocol OrderDetailEditorDelegate {
    func detailUpdated(sender: OrderDetailCell)
}

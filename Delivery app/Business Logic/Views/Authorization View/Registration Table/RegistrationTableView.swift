//
//  RegistrationTableView.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 01/06/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

struct RegisterRequest {
    var email: String?
    var password: String?
    var passwordRepeat: String?
}

final class RegistrationTableView: UIView {
    //MARK: - Subviews
    let table = UITableView()
        
    //MARK: - Properties
    let tableData = RegistrationTableData()
        
    //MARK: - Delegate
    var delegate: RegistrationTableDelegate?
        
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
        super.init(coder: coder)
        addViews()
        configureConstraints()
        configureViews()
       }
        
    private func addViews(){
        table.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(table)
    }
        
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: self.topAnchor),
            table.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
        
    private func configureViews() {
        self.backgroundColor = .white
        
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.rowHeight = 80.0
        table.register(AuthDataCell.self, forCellReuseIdentifier: "dataCell")
        table.register(AuthButtonCell.self, forCellReuseIdentifier: "buttonCell")
            
        table.dataSource = self
        table.delegate = self
    }
}

//MARK: - Table View Delegates
extension RegistrationTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.numberOfSections
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.numberOfRowsInSection[section]
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let newCell: AuthDataCell = table.dequeueReusableCell(withIdentifier: "dataCell",
                                                                  for: indexPath) as! AuthDataCell
            newCell.title.text = tableData.titleForRowAtIndex[indexPath.row]
            newCell.textField.placeholder = tableData.titleForRowAtIndex[indexPath.row]
            return newCell
        case 1:
            let newCell: AuthButtonCell = table.dequeueReusableCell(withIdentifier: "buttonCell",
                                                                    for: indexPath) as! AuthButtonCell
            newCell.delegate = self
            newCell.button.setTitle(tableData.buttonTitle, for: .normal)
            return newCell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - Auth Data & Button Delegate
extension RegistrationTableView: AuthButtonDelegate {
    func authButtonPressed() {
        let request = collectAuthData()
        self.delegate?.handleRequest(request: request)
    }
        
    func collectAuthData() -> RegisterRequest {
        let emailCell = table.cellForRow(at: tableData.emailIndexPath) as? AuthDataCell
        let passwordCell = table.cellForRow(at: tableData.passwordIndexPath) as? AuthDataCell
        let passwordRepeatCell = table.cellForRow(at: tableData.passwordRepeatIndexPath) as? AuthDataCell
        return RegisterRequest(email: emailCell?.textField.text,
                               password: passwordCell?.textField.text,
                               passwordRepeat: passwordRepeatCell?.textField.text)
    }
}

//MARK: - WelcomeStepsTableDelegate
protocol RegistrationTableDelegate {
    func handleRequest(request: RegisterRequest)
}

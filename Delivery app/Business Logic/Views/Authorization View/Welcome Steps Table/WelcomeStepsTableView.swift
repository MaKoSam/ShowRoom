//
//  WelcomeStepsTableView.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 01/06/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

struct StepsRequest {
    let name: String?
    let phone: String?
    let address: String?
}

final class WelcomeStepsTableView: UIView {
    //MARK: - Subviews
    let table = UITableView()
    
    //MARK: - Properties
    let tableData = WelcomeStepsTableData()
    
    //MARK: - Delegate
    var delegate: WelcomeStepsTableDelegate?
    
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
extension WelcomeStepsTableView: UITableViewDelegate, UITableViewDataSource {
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
extension WelcomeStepsTableView: AuthButtonDelegate {
    func authButtonPressed() {
        let request = collectAuthData()
        self.delegate?.handleRequest(request: request)
    }
    
    func collectAuthData() -> StepsRequest {
        let nameCell = table.cellForRow(at: tableData.nameIndexPath) as? AuthDataCell
        let phoneCell = table.cellForRow(at: tableData.phoneIndexPath) as? AuthDataCell
        let addressCell = table.cellForRow(at: tableData.addressIndexPath) as? AuthDataCell
        return StepsRequest(name: nameCell?.textField.text,
                            phone: phoneCell?.textField.text,
                            address: addressCell?.textField.text)
    }
}

//MARK: - WelcomeStepsTableDelegate
protocol WelcomeStepsTableDelegate {
    func handleRequest(request: StepsRequest)
}

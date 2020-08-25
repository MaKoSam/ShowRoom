//
//  MenuTableView.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 01/06/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

class MenuTableView: UIView {
    //MARK: - Subview
    let table = UITableView()
    
    //MARK: - Property
    private var tableData: MenuTableData?
    
    //MARK: - Delegate
    var delegate: MenuTableDelegate?
    
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
    
    func setAuthState(authState: AuthState){
        tableData = MenuTableData(authState: authState)
        table.reloadData()
    }
    
    private func addViews() {
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
        table.register(MenuItemCell.self, forCellReuseIdentifier: "itemCell")
        table.register(MenuAuthCell.self, forCellReuseIdentifier: "authCell")
        table.register(MenuPersonalCell.self, forCellReuseIdentifier: "personalCell")
        table.dataSource = self
        table.delegate = self
    }
}

//MARK: - Table View Delegate
extension MenuTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let tableData = tableData else {
            return 80.0
        }
        if tableData.authState == .signedIn {
            switch indexPath.section {
            case 0:
                return 76.0
            default:
                return 80.0
            }
        } else {
            switch indexPath.section {
            case 0:
                return 66.0
            default:
                return 80.0
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData?.numberOfRowsInSection[section] ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableData = tableData else {
            return UITableViewCell()
        }
        if tableData.authState == .signedIn {
            switch indexPath.section {
            case 0:
                let newCell: MenuPersonalCell = table.dequeueReusableCell(withIdentifier: "personalCell",
                                                                          for: indexPath) as! MenuPersonalCell
                if let user = tableData.user {
                    newCell.nameTitle.text = user.name
                    newCell.phoneTitle.text = user.phone
                }
                newCell.delegate = self
                return newCell
            case 1:
                let newCell: MenuItemCell = table.dequeueReusableCell(withIdentifier: "itemCell",
                                                                      for: indexPath) as! MenuItemCell
                newCell.title.text = tableData.personalSectionTitles[indexPath.row]
                newCell.itemImage.image = tableData.personalSectionImage[indexPath.row]
                newCell.delegate = self
                return newCell
            case 2:
                let newCell: MenuItemCell = table.dequeueReusableCell(withIdentifier: "itemCell",
                                                                      for: indexPath) as! MenuItemCell
                newCell.title.text = tableData.informationSectionTitle[indexPath.row]
                newCell.itemImage.image = tableData.informationSectionImage[indexPath.row]
                newCell.delegate = self
                return newCell
            default:
                return UITableViewCell()
            }
        } else {
            switch indexPath.section {
            case 0:
                let newCell: MenuAuthCell = table.dequeueReusableCell(withIdentifier: "authCell",
                                                                      for: indexPath) as! MenuAuthCell
                newCell.delegate = self
                return newCell
            case 1:
                let newCell: MenuItemCell = table.dequeueReusableCell(withIdentifier: "itemCell",
                                                                      for: indexPath) as! MenuItemCell
                newCell.title.text = tableData.informationSectionTitle[indexPath.row]
                newCell.itemImage.image = tableData.informationSectionImage[indexPath.row]
                newCell.delegate = self
                return newCell
            default:
                return UITableViewCell()
            }
        }
    }
}

//MARK: - Menu Personal Delegate & Menu Auth Delegate
extension MenuTableView: MenuPersonalCellDelegate, MenuAuthDelegate {
    func navigateToAuth() {
        delegate?.presentAuth()
    }
    
    func navigateToPersonalInfo() {
        delegate?.presentUserInfo()
    }
}


//MARK: - Menu Item Delegate
extension MenuTableView: MenuItemSelectDelegate {
    func setSelectedItem(_ sender: MenuItemCell) {
        guard let indexPath = table.indexPath(for: sender),
            let tableData = tableData else {
            return
        }
        if tableData.authState == .signedIn {
            switch indexPath.section {
            case 1:
                if indexPath.row == 0 {
                    delegate?.presentUserOrders()
                } else if indexPath.row == 1 {
                    delegate?.presentUserAddress()
                }
            case 2:
                if indexPath.row == 0 {
                    delegate?.presentDeliveryInfo()
                } else if indexPath.row == 1 {
                    delegate?.presentCall()
                } else if indexPath.row == 2 {
                    delegate?.presentFeedback()
                } else if indexPath.row == 3 {
                    delegate?.presentAppInfo()
                }
            default:
                return
            }
        } else {
            if indexPath.row == 0 {
                delegate?.presentDeliveryInfo()
            } else if indexPath.row == 1 {
                delegate?.presentCall()
            } else if indexPath.row == 2 {
                delegate?.presentFeedback()
            } else if indexPath.row == 3 {
                delegate?.presentAppInfo()
            }
        }
    }
}


//MARK: - Menu Table Delegate
protocol MenuTableDelegate {
    func presentUserInfo()
    
    func presentUserOrders()
    
    func presentUserAddress()
    
    func presentDeliveryInfo()
    
    func presentCall()
    
    func presentFeedback()
    
    func presentAppInfo()
    
    func presentAuth()
}

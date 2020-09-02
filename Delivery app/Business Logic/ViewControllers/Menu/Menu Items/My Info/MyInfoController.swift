//
//  MyInfoController.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 22/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import UIKit

final class MyInfoController: UIViewController {
    //MARK: - Subviews
    let navigationView = NavigationView()
    var headline = UILabel()
    var infoTable = UITableView()
    
    var commitButton = UIButton()
    
    //MARK: - Properties
    var constraints = [NSLayoutConstraint]()
    var infoManager = MyInfoManager()
    var commitInfo = Session.shared.activeUser
    var authState: AuthState = .signedOut
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if commitInfo == nil {
            authState = .signedOut
            commitButton.setTitle("Авторизируйтесь", for: .normal)
        } else {
            authState = .signedIn
            commitButton.setTitle("Обновить", for: .normal)
        }
        infoManager.updateInformation()
        NSLayoutConstraint.activate(constraints)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func commitChanges(sender: UIButton) {
        switch authState {
        case .signedIn:
            guard let commit = commitInfo else {
                return
            }
            Session.shared.userManager.updateUserName(name: commit.name)
            Session.shared.userManager.updateUserPhone(phone: commit.phone)
            Session.shared.userManager.updateUserEmail(email: commit.email)
            Session.shared.userManager.updateUserAddress(address: commit.address)
            self.navigationController?.popViewController(animated: true)
        case .signedOut:
            AppDelegate.shared.rootViewController.navigateToAuthorizationBranch()
        }
    }
}

extension MyInfoController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoManager.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell:  MyInfoCell = infoTable.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! MyInfoCell
        newCell.title.text = infoManager.items[indexPath.row]
        newCell.textField.text = infoManager.info[indexPath.row]
        newCell.delegate = self
        return newCell
    }
}

extension MyInfoController: EditInfoDelegate {
    func endedEditing(sender: MyInfoCell) {
        guard let indexPath = infoTable.indexPath(for: sender),
            let updated = sender.textField.text else {
            return
        }
        switch indexPath.row {
        case 0:
            commitInfo?.name = updated
        case 1:
            commitInfo?.phone = updated
        case 2:
            commitInfo?.email = updated
        case 3:
            commitInfo?.address = updated
        default:
            return
        }
    }
}

//MARK: - Navigation Delegate
extension MyInfoController: NavigationDelegate {
    func navigateBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

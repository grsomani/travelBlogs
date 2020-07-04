//
//  UsersViewController.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 03/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import UIKit
import MKProgress
import Reachability

class UsersViewController: UIViewController {
    
    @IBOutlet private weak var usersTable: UITableView!
    private var currentPageNumber = 1
    private var usersList = [UserDataModel]()
    private var reachability = try? Reachability()
    private lazy var usersService = {
        return UsersService()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.usersList.isEmpty {
            if let reachability = self.reachability, reachability.connection != .unavailable {
                self.fetchLiveUsers()
            } else {
                self.fetchFromDb()
            }
        }
    }
    
    private func fetchLiveUsers() {
        let usersEndpoint = APIEndpoint.users(page: self.currentPageNumber)
        
        MKProgress.show(true)
        self.usersService.loadUsers(endpoint: usersEndpoint) { (users, error) in
            
            MKProgress.hide()
            
            guard let newUsers = users else {
                return
            }
            
            try? UserDbManager().store(users: newUsers)
            
            self.usersList.append(contentsOf: newUsers)
            self.currentPageNumber += 1
            self.usersTable.reloadData()
        }
    }
    
    private func fetchFromDb() {
        do {
            let users = try UserDbManager().retreiveUsers()
            guard let newUsers = users else {
                //ToDo: Show No Internet error.
                return
            }
            
            self.usersList.append(contentsOf: newUsers)
            self.currentPageNumber += 1
            self.usersTable.reloadData()
        } catch {
            //ToDo: Show No Internet error.
        }
    }
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.reuseIdentifier) as? UsersTableViewCell else {
            return UITableViewCell()
        }
        
        if usersList.count > indexPath.row {
            let currentUserData = self.usersList[indexPath.row]
            let viewModel = UserViewModel(dataModel: currentUserData)
            cell.assign(viewModel: viewModel)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userData = self.usersList[indexPath.row]
        guard let userDetailVC = UserDetailViewController.initWithStoryboard(userData) else {
            return
        }
        self.navigationController?.pushViewController(userDetailVC, animated: true)
    }
}

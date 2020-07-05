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
    @IBOutlet private weak var noNetworkLabel: UILabel!

    private var currentPageNumber = 1
    private var isLoading = false
    private var endOfList = false

    private var usersList = [UserDataModel]()
    private var reachability = try? Reachability()
    private lazy var usersService = {
        return UsersService()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        
        self.fetchUsers()
        self.setupNetworkChecker()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        try? self.reachability?.startNotifier()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.reachability?.stopNotifier()
    }
    
    private func setupNetworkChecker() {
        self.reachability?.whenReachable = { reachability in
            self.fetchUsers()
        }
    }
    
    private func fetchUsers() {
        if let reachability = try? Reachability(),
            reachability.connection != .unavailable {
            self.fetchLiveUsers()
        } else {
            self.fetchFromDb()
        }
    }
    
    private func fetchLiveUsers() {
        //Existing API call running
        if isLoading { return }
        
        let usersEndpoint = APIEndpoint.users(page: self.currentPageNumber)
        
        if currentPageNumber == 1 {
            MKProgress.show(true)
        }
        
        self.isLoading = true
        self.usersService.loadUsers(endpoint: usersEndpoint) { (users, error) in
            
            MKProgress.hide()
            self.usersTable.tableFooterView?.isHidden = true

            guard let newUsers = users else {
                return
            }
            
            self.isLoading = false
            self.endOfList = newUsers.count == 0
            
            try? UserDbManager().store(users: newUsers)
            
            self.showData()
            self.usersList.append(contentsOf: newUsers)
            self.currentPageNumber += 1
            self.usersTable.reloadData()
        }
    }
    
    private func fetchFromDb() {
        do {
            let users = try UserDbManager().retreiveUsers(offset: self.usersList.count)
            guard let newUsers = users else {
                return
            }
            
            if newUsers.count == 0 {
                self.endOfList = true
                self.showNetworkIssueIfRequired()
                return
            }
            
            self.showData()
            self.usersList.append(contentsOf: newUsers)
            self.currentPageNumber += 1
            self.usersTable.reloadData()
        } catch {
            self.showNetworkIssueIfRequired()
        }
    }
    
    private func showData() {
        self.noNetworkLabel.isHidden = true
        self.usersTable.isHidden = false
    }
    
    private func showNetworkIssueIfRequired() {
        if self.usersList.count == 0,
            let reachability = try? Reachability(),
            reachability.connection == .unavailable {
            self.noNetworkLabel.isHidden = false
            self.usersTable.isHidden = true
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.usersList.count-1 && !self.endOfList {
            let indicator = UIActivityIndicatorView(style: .gray)
            indicator.startAnimating()
            indicator.frame = CGRect(origin: .zero, size: CGSize(width: 50, height: 50))
            tableView.tableFooterView = indicator
            tableView.tableFooterView?.isHidden = false
            self.fetchUsers()
        }
    }
}

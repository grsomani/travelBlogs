//
//  ArticleViewController.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 01/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import UIKit
import MKProgress
import Reachability

class ArticleViewController: UIViewController {
    
    @IBOutlet private weak var articlesTable: UITableView!
    private var currentPageNumber = 1
    private var articlesList = [ArticleDataModel]()
    private var reachability = try? Reachability()
    private lazy var articlesService = {
        return ArticlesService()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.articlesList.isEmpty {
            if let reachability = self.reachability, reachability.connection != .unavailable {
                self.fetchLiveArticles()
            } else {
                self.fetchFromDb()
            }
        }
    }
    
    private func fetchLiveArticles() {
        let articleEndpoint = APIEndpoint.article(page: self.currentPageNumber)
        
        MKProgress.show(true)
        self.articlesService.loadArticles(endpoint: articleEndpoint) { (articles, error) in
            
            MKProgress.hide()
            
            guard let newArticles = articles else {
                //ToDO: Handling error like error message, fetching data from DB, etc
                return
            }
            self.articlesList.append(contentsOf: newArticles)
            self.currentPageNumber += 1
            self.articlesTable.reloadData()
        }
    }
    
    private func fetchFromDb() {
        
    }
}

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier) else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    
}

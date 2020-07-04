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
        self.title = "Articles"
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
                return
            }
            
            //Delete old entries
            let dbManager = ArticleDbManager()
            try? dbManager.removeAllArticles()
            try? dbManager.store(articles: newArticles)
            
            self.articlesList.append(contentsOf: newArticles)
            self.currentPageNumber += 1
            self.articlesTable.reloadData()
        }
    }
    
    private func fetchFromDb() {
        do {
            let articles = try ArticleDbManager().retreiveArticles()
            guard let newArticles = articles else {
                //ToDo: Show No Internet error.
                return
            }
            
            self.articlesList.append(contentsOf: newArticles)
            self.currentPageNumber += 1
            self.articlesTable.reloadData()
        } catch {
            //ToDo: Show No Internet error.
        }
    }
}

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        if articlesList.count > indexPath.row {
            let currentArticleData = self.articlesList[indexPath.row]
            let viewModel = ArticleViewModel(dataModel: currentArticleData)
            cell.assign(viewModel: viewModel)
        }
        
        cell.selectionStyle = .none
        return cell
    }
}

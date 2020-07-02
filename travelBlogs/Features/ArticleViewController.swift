//
//  ArticleViewController.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 01/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    @IBOutlet private weak var articlesTable: UITableView!
    private var currentPageNumber = 1
    private var articlesList = [ArticleDataModel]()
    private lazy var articlesService = {
        return ArticlesService()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchArticles()
    }
    
    private func fetchArticles() {
        let articleEndpoint = APIEndpoint.article(page: self.currentPageNumber)
        self.articlesService.loadArticles(endpoint: articleEndpoint) { (articles, error) in
            guard let newArticles = articles else {
                //ToDO: Handling error like error message, fetching data from DB, etc
                return
            }
            self.articlesList.append(contentsOf: newArticles)
            self.currentPageNumber += 1
            self.articlesTable.reloadData()
        }
    }
}

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .red
        return cell
    }
    
    
}

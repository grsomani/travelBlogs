//
//  ArticleViewModel.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 02/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import UIKit

struct ArticleViewModel {
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    private var dataModel: ArticleDataModel
    
    init(dataModel: ArticleDataModel) {
        self.dataModel = dataModel
    }
    
    //MARK: User Details
    var userName: String {
        let firstName = self.dataModel.user?.first?.name ?? ""
        let lastName = self.dataModel.user?.first?.lastname ?? ""
        return firstName + " " + lastName
    }
    
    var designation: String {
        return self.dataModel.user?.first?.designation ?? ""
    }
    
    var userImageURL: URL? {
        guard let urlString = self.dataModel.user?.first?.avatar else {
            return nil
        }
        return URL(string: urlString)
    }
    
    //Article Details
    var timeElapsed: String {
        let dateString = self.dataModel.createdAt ?? ""
        let date = ArticleViewModel.dateFormatter.date(from: dateString) ?? Date()
        return date.getElapsedTime()
    }
    
    var articleDescription: String {
        return self.dataModel.content ?? ""
    }
    
    var articleTitle: String? {
        return self.dataModel.media?.first?.title
    }
    
    var articleURL: String? {
        return self.dataModel.media?.first?.url
    }
    
    var articleImageURL: URL? {
        guard let urlString = self.dataModel.media?.first?.image else {
            return nil
        }
        return URL(string: urlString)
    }
    
    var numberOfLikes: String {
        let likes = self.roundedWithAbbreviations(self.dataModel.likes ?? 0)
        return "\(likes) Likes"
    }
    
    var numberOfComments: String {
        let comments = self.roundedWithAbbreviations(self.dataModel.comments ?? 0)
        return "\(comments) Comments"
    }
    
    private func roundedWithAbbreviations(_ input: Int) -> String {
        let number = Double(input)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(input)"
        }
    }
}

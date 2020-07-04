//
//  ArticleDbManager.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 04/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import Foundation
import CoreData

struct ArticleDbManager {
    
    func store(articles: [ArticleDataModel]) throws {
        
        guard let context = StoreManager.managedObjectContext else {
            return
        }
        
        if let articleEntity = NSEntityDescription.entity(forEntityName: "DBArticle", in: context) {
            
            for article in articles {
                
                let articleToAdd = DBArticle(entity: articleEntity,
                                           insertInto: context)
                articleToAdd.id = article.id
                articleToAdd.createdAt = article.createdAt
                articleToAdd.content = article.content
                articleToAdd.likes = Int32(article.likes ?? 0)
                articleToAdd.comments = Int32(article.comments ?? 0)
                
                if let users = article.user,
                    let userEntity = NSEntityDescription.entity(forEntityName: "DBUser", in: context) {
                    for user in users {
                        let userToAdd = self.createDBUser(user, entity: userEntity, context: context)
                        articleToAdd.addToUser(userToAdd)
                    }
                }
                
                if let medias = article.media,
                    let mediaEntity = NSEntityDescription.entity(forEntityName: "DBMedia", in: context) {
                    for media in medias {
                        let mediaToAdd = self.createDBMedia(media, entity: mediaEntity, context: context)
                        articleToAdd.addToMedia(mediaToAdd)
                    }
                }
                
                try context.save()
            }
        } else {
            print("Entity not found")
        }
    }
    
    func retreiveArticles() throws -> [ArticleDataModel]? {
        guard let context = StoreManager.managedObjectContext else {
            return nil
        }
        
        let request:NSFetchRequest<DBArticle> = DBArticle.fetchRequest()
        
        let articles = try context.fetch(request)
        var data: [ArticleDataModel] = []

        for article in articles {
            
            var articleUsers: [User] = []
            var articleMedia: [Media] = []

            article.user?.forEach({ user in
                if let userData = user as? DBUser {
                    articleUsers.append(userData.convertToDataModel())
                }
            })
            
            article.media?.forEach({ media in
                if let mediaData = media as? DBMedia {
                    articleMedia.append(mediaData.convertToDataModel())
                }
            })
            
            data.append(
                ArticleDataModel(id: article.id,
                                 createdAt: article.createdAt,
                                 content: article.content,
                                 comments: Int(article.comments),
                                 likes: Int(article.likes),
                                 media: articleMedia,
                                 user: articleUsers)
            )
        }
        return data
    }
    
    func removeAllArticles() throws {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DBArticle")
        let request = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        guard let storeCoordinator = StoreManager.persistentStoreCoordinator,
            let context = StoreManager.managedObjectContext else {
                return
        }
        
        try storeCoordinator.execute(request, with: context)
    }
    
    
    private func createDBUser(_ user: User, entity: NSEntityDescription, context: NSManagedObjectContext) -> DBUser {
        let userToAdd = DBUser(entity: entity,
                               insertInto: context)
        userToAdd.id = user.id
        userToAdd.name = user.name
        userToAdd.lastName = user.lastname
        userToAdd.blogID = user.blogID
        userToAdd.createdAt = user.createdAt
        userToAdd.avatar = user.avatar
        userToAdd.city = user.city
        userToAdd.designation = user.designation
        userToAdd.about = user.about
        return userToAdd
    }
    
    private func createDBMedia(_ media: Media, entity: NSEntityDescription, context: NSManagedObjectContext) -> DBMedia {
        let mediaToAdd = DBMedia(entity: entity,
                               insertInto: context)
        mediaToAdd.id = media.id
        mediaToAdd.blogID = media.blogID
        mediaToAdd.createdAt = media.createdAt
        mediaToAdd.image = media.image
        mediaToAdd.title = media.title
        mediaToAdd.url = media.url
        return mediaToAdd
    }
}

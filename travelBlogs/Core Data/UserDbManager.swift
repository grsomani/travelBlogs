//
//  UserDbManager.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 04/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import Foundation
import CoreData

struct UserDbManager {
    
    func store(users: [UserDataModel]) throws {
        
        guard let context = StoreManager.managedObjectContext else {
            return
        }
        
        if let userEntity = NSEntityDescription.entity(forEntityName: "DBUser", in: context) {
            
            for user in users {
                if try StoreManager.entityExist(id: user.id ?? "",
                                                entityName: "DBUser",
                                                context: context) {
                    continue
                }
                let userToAdd = DBUser(entity: userEntity, insertInto: context)
                userToAdd.id = user.id
                userToAdd.name = user.name
                userToAdd.lastName = user.lastname
                userToAdd.createdAt = user.createdAt
                userToAdd.avatar = user.avatar
                userToAdd.city = user.city
                userToAdd.designation = user.designation
                userToAdd.about = user.about

                try context.save()
            }
        } else {
            print("Entity not found")
        }
    }
    
    func retreiveUsers() throws -> [UserDataModel]? {
        guard let context = StoreManager.managedObjectContext else {
            return nil
        }
        
        let request:NSFetchRequest<DBUser> = DBUser.fetchRequest()
        
        let users = try context.fetch(request)
        var data: [UserDataModel] = []

        users.forEach({ data.append($0.convertToUserDataModel()) })
        return data
    }
}

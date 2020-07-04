//
//  DBUser+CoreDataClass.swift
//  
//
//  Created by Ganesh Somani on 04/07/20.
//
//

import Foundation
import CoreData

@objc(DBUser)
public class DBUser: NSManagedObject {
    
    func convertToDataModel() -> User {
        return User(id: self.id,
                    blogID: self.blogID,
                    createdAt: self.createdAt,
                    name: self.name,
                    avatar: self.avatar,
                    lastname: self.lastName,
                    city: self.city,
                    designation: self.designation,
                    about: self.about)
    }
    
    func convertToUserDataModel() -> UserDataModel {
        return UserDataModel(id: self.id,
                             createdAt: self.createdAt,
                             name: self.name,
                             avatar: self.avatar,
                             lastname: self.lastName,
                             city: self.city,
                             designation: self.designation,
                             about: self.about)
    }
}

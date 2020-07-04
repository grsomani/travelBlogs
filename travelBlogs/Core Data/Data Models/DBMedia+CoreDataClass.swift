//
//  DBMedia+CoreDataClass.swift
//  
//
//  Created by Ganesh Somani on 04/07/20.
//
//

import Foundation
import CoreData

@objc(DBMedia)
public class DBMedia: NSManagedObject {

    func convertToDataModel() -> Media {
        return Media(id: self.id,
                     blogID: self.blogID,
                     createdAt: self.createdAt,
                     image: self.image,
                     title: self.title,
                     url: self.url)
    }
}

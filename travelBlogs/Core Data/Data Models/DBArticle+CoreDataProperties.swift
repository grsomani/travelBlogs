//
//  DBArticle+CoreDataProperties.swift
//  
//
//  Created by Ganesh Somani on 04/07/20.
//
//

import Foundation
import CoreData


extension DBArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBArticle> {
        return NSFetchRequest<DBArticle>(entityName: "DBArticle")
    }

    @NSManaged public var id: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var content: String?
    @NSManaged public var likes: Int32
    @NSManaged public var comments: Int32
    @NSManaged public var user: NSSet?
    @NSManaged public var media: NSSet?

}

// MARK: Generated accessors for user
extension DBArticle {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: DBUser)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: DBUser)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

// MARK: Generated accessors for media
extension DBArticle {

    @objc(addMediaObject:)
    @NSManaged public func addToMedia(_ value: DBMedia)

    @objc(removeMediaObject:)
    @NSManaged public func removeFromMedia(_ value: DBMedia)

    @objc(addMedia:)
    @NSManaged public func addToMedia(_ values: NSSet)

    @objc(removeMedia:)
    @NSManaged public func removeFromMedia(_ values: NSSet)

}

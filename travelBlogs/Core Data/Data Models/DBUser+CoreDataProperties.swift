//
//  DBUser+CoreDataProperties.swift
//  
//
//  Created by Ganesh Somani on 04/07/20.
//
//

import Foundation
import CoreData


extension DBUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBUser> {
        return NSFetchRequest<DBUser>(entityName: "DBUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var blogID: String?
    @NSManaged public var name: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var avatar: String?
    @NSManaged public var lastName: String?
    @NSManaged public var city: String?
    @NSManaged public var designation: String?
    @NSManaged public var about: String?

}

//
//  DBMedia+CoreDataProperties.swift
//  
//
//  Created by Ganesh Somani on 04/07/20.
//
//

import Foundation
import CoreData


extension DBMedia {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBMedia> {
        return NSFetchRequest<DBMedia>(entityName: "DBMedia")
    }

    @NSManaged public var id: String?
    @NSManaged public var blogID: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}

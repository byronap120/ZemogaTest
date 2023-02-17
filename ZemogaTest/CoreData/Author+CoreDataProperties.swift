//
//  Author+CoreDataProperties.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 16/02/23.
//
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: "Author")
    }

    @NSManaged public var id: Int64
    @NSManaged public var username: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var website: String?
    @NSManaged public var name: String?

}

extension Author : Identifiable {

}

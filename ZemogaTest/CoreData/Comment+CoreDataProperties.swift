//
//  Comment+CoreDataProperties.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var body: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var postId: Int64
    @NSManaged public var post: Post?

}

extension Comment : Identifiable {

}

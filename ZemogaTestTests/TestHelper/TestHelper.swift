//
//  TestHelper.swift
//  ZemogaTestTests
//
//  Created by Byron Ajin on 17/02/23.
//

import XCTest
import CoreData
@testable import ZemogaTest

class TestHelper {
    
      func createPostMock(mockManagedObjectContext: NSManagedObjectContext) -> Post {
         let mockPost = Post(entity: Post.entity(), insertInto: mockManagedObjectContext)
         mockPost.id = 1
         mockPost.title = "Test Title"
         mockPost.body = "Test Body"
         mockPost.isFavorite = false
         return mockPost
    }
    
     func createAuthorMock(mockManagedObjectContext: NSManagedObjectContext) -> Author {
        let mockAuthor = Author(entity: Author.entity(), insertInto: mockManagedObjectContext)
        mockAuthor.id = 1
        mockAuthor.name = "John"
        mockAuthor.email = "john@gmail.com"
        mockAuthor.phone = "+1 123456789"
        mockAuthor.username = "John10"
        mockAuthor.website = "johnwebsite.com"
        return mockAuthor
    }
    
     func createArrayOfCommentsMock(mockManagedObjectContext: NSManagedObjectContext) -> [Comment]{
        let mockComment1 = Comment(entity: Comment.entity(), insertInto: mockManagedObjectContext)
        mockComment1.id = 1
        mockComment1.body = "Comment 1"
        
        let mockComment2 = Comment(entity: Comment.entity(), insertInto: mockManagedObjectContext)
        mockComment2.id = 2
        mockComment2.body = "Comment 2"
    
        return [mockComment1, mockComment2]
    }
    
    static func createArrayOfPosts(mockManagedObjectContext: NSManagedObjectContext) -> [Post]{
        let mockPost = Post(entity: Post.entity(), insertInto: mockManagedObjectContext)
        mockPost.id = 3
        mockPost.title = "Test Title"
        mockPost.body = "Test Body"
        mockPost.isFavorite = false
        
        let mockPost2 = Post(entity: Post.entity(), insertInto: mockManagedObjectContext)
        mockPost2.id = 4
        mockPost2.title = "Test Title 2"
        mockPost2.body = "Test Body 2"
        mockPost2.isFavorite = false
        
        return [mockPost, mockPost2]
    }
}

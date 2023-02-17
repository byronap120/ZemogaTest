//
//  DataManager.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//

import Foundation
import CoreData

class DataManager {
    static let shared = DataManager()

    init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostsModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func getPostDetails(postId: Int64, userId: Int64, completion: @escaping (Author?, [Comment]) -> Void){
        let authorFetchRequest: NSFetchRequest<Author> = Author.fetchRequest()
        authorFetchRequest.predicate = NSPredicate(format: "id == %d", userId)
        authorFetchRequest.fetchLimit = 1
        
        let commentFetchRequest: NSFetchRequest<Comment> = Comment.fetchRequest()
        commentFetchRequest.predicate = NSPredicate(format: "postId == %d", postId)
        
        do {
            let author = try persistentContainer.viewContext.fetch(authorFetchRequest).first
            let comments = try persistentContainer.viewContext.fetch(commentFetchRequest)
            completion(author, comments)
        } catch {
            print("Failed to fetch comments for post ID \(postId): \(error)")
        }
    }
    
    func getPosts(completion: @escaping ([Post]) -> Void) {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        let sortDescriptor1 = NSSortDescriptor(key: "isFavorite", ascending: false)
        let sortDescriptor2 = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]

        do {
            let posts = try persistentContainer.viewContext.fetch(fetchRequest)
            completion(posts)
        } catch {
            print("Failed to fetch posts: \(error)")
            completion([])
        }
    }
    
    func update(post: Post, completion: @escaping (Bool) -> Void) {
        do {
            try persistentContainer.viewContext.save()
            completion(true)
        } catch {
            print("Failed to update post: \(error)")
            completion(false)
        }
    }
    
    
    func deletePost(post: Post, completion: @escaping (Bool) -> Void) {
        do {
            persistentContainer.viewContext.delete(post)
            try persistentContainer.viewContext.save()
            completion(true)
        } catch {
            print("Failed to delete post: \(error)")
            completion(false)
        }
    }
    
    func removeAllUnfavoritePosts(completion: @escaping () -> Void) {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isFavorite == %@",NSNumber(booleanLiteral: false))
        do {
            let unfavoritePosts = try persistentContainer.viewContext.fetch(fetchRequest)
            for post in unfavoritePosts {
                persistentContainer.viewContext.delete(post)
            }
            try persistentContainer.viewContext.save()
            completion()
        } catch {
            print("Error removing unfavorite posts: \(error)")
        }
    }
    
    func removeAllPosts(completion: @escaping () -> Void) {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        let fetchCommentRequest: NSFetchRequest<Comment> = Comment.fetchRequest()
        let fetchAuthorRequest: NSFetchRequest<Author> = Author.fetchRequest()
        do {
            let posts = try persistentContainer.viewContext.fetch(fetchRequest)
            for post in posts {
                persistentContainer.viewContext.delete(post)
            }
            
            let comments = try persistentContainer.viewContext.fetch(fetchCommentRequest)
            for comment in comments {
                persistentContainer.viewContext.delete(comment)
            }
            
            let authors = try persistentContainer.viewContext.fetch(fetchAuthorRequest)
            for author in authors {
                persistentContainer.viewContext.delete(author)
            }
            
            try persistentContainer.viewContext.save()
            completion()
        } catch {
            print("Error deleting data: \(error)")
        }
    }
    
    func saveDataFromService(postResponses: [PostResponse],
                             userResponses: [UsersResponse],
                             commentResponses: [CommentResponse],
                             successSaving: @escaping () -> Void,
                             errorSaving: @escaping (String) -> Void) {
        persistentContainer.performBackgroundTask{ context in
            for postResponse in postResponses {
                let post = Post(context: context)
                post.body = postResponse.body
                post.id = Int64(postResponse.id ?? 0)
                post.isFavorite = false
                post.title = postResponse.title
                post.userId = Int64(postResponse.userId ?? 0)
            }
            
            for commentResponse in commentResponses {
                let comment = Comment(context: context)
                comment.id = Int64(commentResponse.id ?? 0)
                comment.body = commentResponse.body
                comment.postId = Int64(commentResponse.id ?? 0)
                comment.name = commentResponse.name
                comment.email = commentResponse.email
            }
            
            for userResponse in userResponses {
                let author = Author(context: context)
                author.id = Int64(userResponse.id ?? 0)
                author.name = userResponse.name
                author.username = userResponse.username
                author.email = userResponse.email
            }
            
            do {
                try context.save()
                print("Saved \(commentResponses.count) posts and their comments to Core Data.")
                DispatchQueue.main.async {
                    successSaving()
                }
            } catch let error {
                print("Failed to save posts to Core Data: \(error.localizedDescription)")
                errorSaving("Failed to save posts to Core Data: \(error.localizedDescription)")
            }
        }
        
    }
}

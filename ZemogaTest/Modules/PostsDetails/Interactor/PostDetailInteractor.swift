//
//  PostDetailInteractor.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 16/02/23.
//

import Foundation

class PostDetailInteractor: PresenterToInteractorPostDetailProtocol {
    
    var presenter: InteractorToPesenterPostDetailProtocol?
    
    var dataManager: DataManager?
        
    func getDetails(postId: Int64, userId: Int64) {
        dataManager?.getPostDetails(postId: postId, userId: userId) { autor, comments in
            self.presenter?.fetchDetailSuccess(author: autor, comments: comments)
        }
    }
    
    func updatePost(post: Post) {
        dataManager?.update(post: post, completion: {_ in ()})
    }
    
    func deletePost(post: Post) {
        dataManager?.deletePost(post: post, completion: {_ in ()})
    }
}

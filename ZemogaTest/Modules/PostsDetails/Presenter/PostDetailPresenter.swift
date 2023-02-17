//
//  PostDetailPresenter.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 16/02/23.
//

import Foundation

class PostDetailPresenter: ViewToPresenterPostDetailProtocol {
    
    var view: PresenterToViewPostDetailProtocol?
    var interactor: PresenterToInteractorPostDetailProtocol?
    
    func fetchDetails(postId: Int64, userId: Int64) {
        interactor?.getDetails(postId: postId, userId: userId)
    }
    
    func updatePost(post: Post) {
        interactor?.updatePost(post: post)
    }
    
    func deletePost(post: Post) {
        interactor?.deletePost(post: post)
    }
}

extension PostDetailPresenter: InteractorToPesenterPostDetailProtocol {
    
    func fetchDetailSuccess(author: Author?, comments: [Comment]) {
        view?.onFetchDetailSuccess(author: author, comments: comments)
    }
    
    func fetchDetailFailure(error: String) {
        view?.onFetchDetailFailure(error: error)
    }
}

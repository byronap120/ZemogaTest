//
//  PostsPresenter.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//

import Foundation

class PostPresenter: ViewToPresenterPostProtocol {
        
    var view: PresenterToViewPostProtocol?
    var interactor: PresenterToInteractorPostProtocol?
    
    func fetchPosts() {
        view?.showLoader()
        interactor?.loadPosts()
    }
    
    func updatePost(post: Post) {
        interactor?.updatePost(post: post)
    }
    
    func deleteUnfavoritePosts() {
        interactor?.deleteUnfavoritePosts()
    }
    
    func reloadPostsFromAPI() {
        view?.showLoader()
        interactor?.reloadPostsFromAPI()
    }
    
}

extension PostPresenter: InteractorToPesenterPostProtocol {
    
    func fetchPostsSuccess(postList: Array<Post>) {
        view?.onFetchPostsSuccess(postList: postList)
        view?.hideLoader()
    }
    
    func fetchPostsFailure(error: String) {
        view?.onFetchPostsFailure(error: error)
        view?.hideLoader()
    }
}

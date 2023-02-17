//
//  PostsProtocol.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//

import Foundation

// MARK: View Protocols
protocol PresenterToViewPostProtocol: AnyObject {
    func onFetchPostsSuccess(postList: Array<Post>)
    func onFetchPostsFailure(error: String)
    func showLoader()
    func hideLoader()
}

protocol PostUpdateDelegate: AnyObject {
    func postWasUpdated(_ post: Post)
}

// MARK: Presenter Protocols
protocol ViewToPresenterPostProtocol: AnyObject {
    var view: PresenterToViewPostProtocol? { get set }
    var interactor: PresenterToInteractorPostProtocol? { get set }
    
    func fetchPosts()
    func updatePost(post: Post)
    func deleteUnfavoritePosts()
    func reloadPostsFromAPI()
}

protocol InteractorToPesenterPostProtocol: AnyObject {
    func fetchPostsSuccess(postList: Array<Post>)
    func fetchPostsFailure(error: String)
}


// MARK: Interactor Protocols
protocol PresenterToInteractorPostProtocol: AnyObject {
    var presenter: InteractorToPesenterPostProtocol? { get set }
    var networkService: NetworkService? { get set }
    var dataManager: DataManager? {get set}

    func loadPosts()
    func updatePost(post: Post)
    func deleteUnfavoritePosts()
    func reloadPostsFromAPI()
}

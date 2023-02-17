//
//  PostDetailProtocol.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 16/02/23.
//

import Foundation

// MARK: View Protocols
protocol PresenterToViewPostDetailProtocol: AnyObject {
    func onFetchDetailSuccess(author: Author?, comments: [Comment])
    func onFetchDetailFailure(error: String)
}

// MARK: Presenter Protocols
protocol ViewToPresenterPostDetailProtocol: AnyObject {
    var view: PresenterToViewPostDetailProtocol? { get set }
    var interactor: PresenterToInteractorPostDetailProtocol? { get set }
    
    func fetchDetails(postId: Int64, userId: Int64)
    func updatePost(post: Post)
    func deletePost(post: Post)
}

protocol InteractorToPesenterPostDetailProtocol: AnyObject {
    func fetchDetailSuccess(author: Author?, comments: [Comment])
    func fetchDetailFailure(error: String)
}


// MARK: Interactor Protocols
protocol PresenterToInteractorPostDetailProtocol: AnyObject {
    var presenter: InteractorToPesenterPostDetailProtocol? { get set }
    var dataManager: DataManager? {get set}

    func getDetails(postId: Int64, userId: Int64)
    func updatePost(post: Post)
    func deletePost(post: Post)
}

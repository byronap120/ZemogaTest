//
//  PostsInteractor.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//

import Foundation

class PostsInteractor: PresenterToInteractorPostProtocol {

    var presenter: InteractorToPesenterPostProtocol?

    var networkService: NetworkService?
    
    var dataManager: DataManager?

    func loadPosts(){
        // Check if database is empty or local Posts exists
        dataManager?.getPosts(completion: {(posts) in
            if(posts.isEmpty) {
                self.loadDataFromService()
            } else {
                self.presenter?.fetchPostsSuccess(postList: posts)
            }
        })
    }
    
    func updatePost(post: Post) {
        dataManager?.update(post: post, completion: {_ in ()})
    }
    
    func deleteUnfavoritePosts() {
        dataManager?.removeAllUnfavoritePosts(completion: {
            self.dataManager?.getPosts(completion: { (posts) in
                self.presenter?.fetchPostsSuccess(postList: posts)
            })
        })
    }
    
    func reloadPostsFromAPI() {
        dataManager?.removeAllPosts(completion: {
            self.loadDataFromService()
        })
    }
    
    private func loadDataFromService(){
        networkService?.fetchPostData { result in
            switch result {
            case .success(let (posts, comments, users)):
                self.saveDataToDB(postResponses: posts, userResponses: users, commentResponses: comments)
            case .failure(let error):
                print("Error fetching post data: \(error.localizedDescription)")
            }
        }
    }
    
    private func saveDataToDB(postResponses: [PostResponse],
                              userResponses: [UsersResponse],
                              commentResponses: [CommentResponse]){
        dataManager?.saveDataFromService(postResponses: postResponses,
                                               userResponses: userResponses,
                                               commentResponses: commentResponses,
                                               successSaving: successSavingHandler,
                                               errorSaving: failureSavingHandler)
    }
    
    private func successSavingHandler(){
        dataManager?.getPosts(completion: {(posts) in
            self.presenter?.fetchPostsSuccess(postList: posts)
        })
    }
    
    private func failureSavingHandler(error: String) {
        presenter?.fetchPostsFailure(error: error)
    }
}

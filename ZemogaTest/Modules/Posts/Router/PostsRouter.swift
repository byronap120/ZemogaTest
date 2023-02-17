//
//  PostsRouter.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 15/02/23.
//

import UIKit

class PostsRouter {
    class func createModule(postView: PostsViewController){
        let presenter = PostPresenter()
        postView.presenter = presenter
        postView.presenter?.view = postView
        postView.presenter?.interactor = PostsInteractor()
        postView.presenter?.interactor?.presenter = presenter
        postView.presenter?.interactor?.networkService = NetworkService()
        postView.presenter?.interactor?.dataManager = DataManager.shared
    }
}

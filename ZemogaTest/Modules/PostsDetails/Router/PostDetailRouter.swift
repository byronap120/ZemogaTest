//
//  PostDetailRouter.swift
//  ZemogaTest
//
//  Created by Byron Ajin on 16/02/23.
//

import Foundation

class PostDetailRouter {
    class func createModule(detailView: PostsDetailViewController){
        let presenter = PostDetailPresenter()
        detailView.presenter = presenter
        detailView.presenter?.view = detailView
        detailView.presenter?.interactor = PostDetailInteractor()
        detailView.presenter?.interactor?.presenter = presenter
        detailView.presenter?.interactor?.dataManager = DataManager.shared
    }
}

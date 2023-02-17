//
//  PostInteractorTests.swift
//  ZemogaTestTests
//
//  Created by Byron Ajin on 17/02/23.
//

import XCTest
import CoreData
@testable import ZemogaTest

class PostsInteractorTests: CoreDataTestCase {

    var interactor: PostsInteractor!
    var mockPresenter: MockPostsPresenter!
    var mockDataManager: MockDataManagerPost!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockPresenter = MockPostsPresenter()
        mockDataManager = MockDataManagerPost()
        mockNetworkService = MockNetworkService()
        interactor = PostsInteractor()
        interactor.presenter = mockPresenter
        interactor.dataManager = mockDataManager
        interactor.networkService = mockNetworkService
    }

    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        mockDataManager = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testLoadPosts_WithEmptyDatabase_ShouldCallLoadDataFromService() {
        // Given
        mockDataManager.posts = []

        // When
        interactor.loadPosts()

        // Then
        XCTAssertTrue(mockDataManager.getPostsCalled)
        XCTAssertTrue(mockNetworkService.fetchPostDataCalled)
    }
}

class MockPostsPresenter: InteractorToPesenterPostProtocol {

    var fetchPostsSuccessCalled = false
    var fetchPostsFailureCalled = false
    var posts: [Post]?

    func fetchPostsSuccess(postList: Array<Post>) {
        fetchPostsSuccessCalled = true
        posts = postList
    }

    func fetchPostsFailure(error: String) {
        fetchPostsFailureCalled = true
    }
}

class MockDataManagerPost: DataManager {

    var getPostsCalled = false
    var removeAllPostsCalled = false
    var removeAllUnfavoritePostsCalled = false
    var posts: [Post]?

    override func getPosts(completion: @escaping ([Post]) -> Void) {
        getPostsCalled = true
        completion(posts ?? [])
    }

    override func removeAllPosts(completion: @escaping () -> Void) {
        removeAllPostsCalled = true
        completion()
    }

    override func removeAllUnfavoritePosts(completion: @escaping () -> Void) {
        removeAllUnfavoritePostsCalled = true
        completion()
    }

}

class MockNetworkService: NetworkService {

    var fetchPostDataCalled = false

    override func fetchPostData(completion: @escaping (Result<([PostResponse], [CommentResponse], [UsersResponse]), Error>) -> Void) {
        fetchPostDataCalled = true
        completion(.success(([PostResponse](), [CommentResponse](), [UsersResponse]())))
    }

}


//
//  PostPresenterTest.swift
//  ZemogaTestTests
//
//  Created by Byron Ajin on 17/02/23.
//

import XCTest
import CoreData
@testable import ZemogaTest

class PostPresenterTests: CoreDataTestCase {

    var presenter: PostPresenter!
    var mockView: MockViewPost!
    var mockInteractor: MockInteractorPost!
    var postPresenterCTX: NSManagedObjectContext!


    override func setUp() {
        super.setUp()
        mockView = MockViewPost()
        mockInteractor = MockInteractorPost()
        presenter = PostPresenter()
        presenter.view = mockView
        presenter.interactor = mockInteractor
        postPresenterCTX = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    }

    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        presenter = nil
        super.tearDown()
    }

    func testFetchPosts() {
        presenter.fetchPosts()
        XCTAssertTrue(mockView.showLoaderCalled)
        XCTAssertTrue(mockInteractor.loadPostsCalled)
    }

    func testUpdatePost() {
        // Given
        let mockPost = TestHelper().createPostMock(mockManagedObjectContext: contextForTest)
        // When
        presenter.updatePost(post: mockPost)
        // Then
        XCTAssertTrue(mockInteractor.updatePostCalled)
        XCTAssertEqual(mockInteractor.post, mockPost)
    }

    func testDeleteUnfavoritePosts() {
        // When
        presenter.deleteUnfavoritePosts()
        // Then
        XCTAssertTrue(mockInteractor.deleteUnfavoritePostsCalled)
    }

    func testReloadPostsFromAPI() {
        // When
        presenter.reloadPostsFromAPI()
        // Then
        XCTAssertTrue(mockView.showLoaderCalled)
        XCTAssertTrue(mockInteractor.reloadPostsFromAPICalled)
    }

    func testFetchPostsFailure() {
        // When
        presenter.fetchPostsFailure(error: "Error")
        // Then
        XCTAssertTrue(mockView.onFetchPostsFailureCalled)
        XCTAssertEqual(mockView.error, "Error")
        XCTAssertTrue(mockView.hideLoaderCalled)
    }
}

class MockViewPost: PresenterToViewPostProtocol {
    var showLoaderCalled = false
    var hideLoaderCalled = false
    var onFetchPostsSuccessCalled = false
    var onFetchPostsFailureCalled = false
    var postList: [Post]?
    var error: String?

    func showLoader() {
        showLoaderCalled = true
    }

    func hideLoader() {
        hideLoaderCalled = true
    }

    func onFetchPostsSuccess(postList: [Post]) {
        onFetchPostsSuccessCalled = true
        self.postList = postList
    }

    func onFetchPostsFailure(error: String) {
        onFetchPostsFailureCalled = true
        self.error = error
    }
}

class MockInteractorPost: PresenterToInteractorPostProtocol {
    var presenter: ZemogaTest.InteractorToPesenterPostProtocol?
    var networkService: ZemogaTest.NetworkService?
    var dataManager: ZemogaTest.DataManager?

    var loadPostsCalled = false
    var updatePostCalled = false
    var post: Post?
    var deleteUnfavoritePostsCalled = false
    var reloadPostsFromAPICalled = false

    func loadPosts() {
        loadPostsCalled = true
    }

    func updatePost(post: Post) {
        updatePostCalled = true
        self.post = post
    }

    func deleteUnfavoritePosts() {
        deleteUnfavoritePostsCalled = true
    }

    func reloadPostsFromAPI() {
        reloadPostsFromAPICalled = true
    }
}


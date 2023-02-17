//
//  PostDetailPresenterTest.swift
//  ZemogaTestTests
//
//  Created by Byron Ajin on 17/02/23.
//

import XCTest
import CoreData
@testable import ZemogaTest

class PostDetailPresenterTests: CoreDataTestCase {
    
    var presenter: PostDetailPresenter!
    var mockView: MockView!
    var mockInteractor: MockInteractor!
    var detailPresenterCTX: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockInteractor = MockInteractor()
        presenter = PostDetailPresenter()
        presenter.view = mockView
        presenter.interactor = mockInteractor
        detailPresenterCTX = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    }
    
    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        presenter = nil
        super.tearDown()
    }
    
    func testFetchDetails() {
        presenter.fetchDetails(postId: 123, userId: 456)
        XCTAssertTrue(mockInteractor.getDetailsCalled)
        XCTAssertEqual(mockInteractor.postId, 123)
        XCTAssertEqual(mockInteractor.userId, 456)
    }
    
    func testUpdatePost() {
        // Given
        let mockPost = TestHelper().createPostMock(mockManagedObjectContext: contextForTest)
        mockPost.id = 1
        mockPost.title = "Test Title"
        mockPost.body = "Test Body"
        mockPost.isFavorite = false
        
        // When
        presenter.updatePost(post: mockPost)
        
        // Then
        XCTAssertTrue(mockInteractor.updatePostCalled)
        XCTAssertEqual(mockInteractor.post, mockPost)
    }
    
    func testDeletePost() {
        // Given
        let mockPost = TestHelper().createPostMock(mockManagedObjectContext: contextForTest)
        // When
        presenter.deletePost(post: mockPost)
        // Then
        XCTAssertTrue(mockInteractor.deletePostCalled)
        XCTAssertEqual(mockInteractor.post, mockPost)
    }
    
    func testFetchDetailSuccess() {
        // Given
        let mockAuthor = TestHelper().createAuthorMock(mockManagedObjectContext: contextForTest)
        let mockComments = TestHelper().createArrayOfCommentsMock(mockManagedObjectContext: contextForTest)
        // When
        presenter.fetchDetailSuccess(author: mockAuthor, comments: mockComments)
        // Then
        XCTAssertTrue(mockView.onFetchDetailSuccessCalled)
        XCTAssertEqual(mockView.author, mockAuthor)
        XCTAssertEqual(mockView.comments, mockComments)
    }
    
    func testFetchDetailFailure() {
        // When
        presenter.fetchDetailFailure(error: "Error")
        // Then
        XCTAssertTrue(mockView.onFetchDetailFailureCalled)
    }
}

class MockView: PresenterToViewPostDetailProtocol {
    var onFetchDetailSuccessCalled = false
    var onFetchDetailFailureCalled = false
    var author: Author?
    var comments: [Comment]?
    
    func onFetchDetailSuccess(author: Author?, comments: [Comment]) {
        onFetchDetailSuccessCalled = true
        self.author = author
        self.comments = comments
    }
    
    func onFetchDetailFailure(error: String) {
        onFetchDetailFailureCalled = true
    }
}

class MockInteractor: PresenterToInteractorPostDetailProtocol {
    var presenter: ZemogaTest.InteractorToPesenterPostDetailProtocol?
    var dataManager: ZemogaTest.DataManager?
    var getDetailsCalled = false
    var postId: Int64?
    var userId: Int64?
    var updatePostCalled = false
    var post: Post?
    var deletePostCalled = false
    
    func getDetails(postId: Int64, userId: Int64) {
        getDetailsCalled = true
        self.postId = postId
        self.userId = userId
    }
    
    func updatePost(post: Post) {
        updatePostCalled = true
        self.post = post
    }
    
    func deletePost(post: Post) {
        deletePostCalled = true
        self.post = post
    }
}


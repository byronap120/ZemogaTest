//
//  PostDetailInteractorTests.swift
//  ZemogaTestTests
//
//  Created by Byron Ajin on 16/02/23.
//

import XCTest
import CoreData
@testable import ZemogaTest


class PostDetailInteractorTests: CoreDataTestCase {
    
    var interactor: PostDetailInteractor!
    var mockPresenter: MockPostDetailPresenter!
    var mockDataManager: MockDataManager!
    var detailInteractorCTX: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockPostDetailPresenter()
        mockDataManager = MockDataManager()
        interactor = PostDetailInteractor()
        interactor.presenter = mockPresenter
        interactor.dataManager = mockDataManager
        detailInteractorCTX = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mockDataManager.managedObjectContext = detailInteractorCTX
    }
    
    override func tearDown() {
        mockPresenter = nil
        mockDataManager = nil
        interactor = nil
        super.tearDown()

    }
    
    func testGetDetails() {
        // Given
        let mockAuthor = TestHelper().createAuthorMock(mockManagedObjectContext: contextForTest)
        let mockComments = TestHelper().createArrayOfCommentsMock(mockManagedObjectContext: contextForTest)
        mockDataManager.mockPostDetails = (mockAuthor, mockComments)
        // When
        interactor.getDetails(postId: 1, userId: 1)
        // Then
        XCTAssertTrue(mockDataManager.isGetPostDetailsCalled)
        XCTAssertEqual(mockDataManager.getPostDetailsPostId, 1)
        XCTAssertEqual(mockDataManager.getPostDetailsUserId, 1)
        XCTAssertEqual(mockPresenter.fetchDetailSuccessAuthor, mockAuthor)
        XCTAssertEqual(mockPresenter.fetchDetailSuccessComments, mockComments)
    }
    
    func testUpdatePost() {
        // Given
        let mockPost = Post(entity: Post.entity(), insertInto: contextForTest)
        mockPost.id = 1
        mockPost.title = "Test Title"
        mockPost.body = "Test Body"
        mockPost.isFavorite = false
        // When
        interactor.updatePost(post: mockPost)
        // Then
        XCTAssertTrue(mockDataManager.isUpdatePostCalled)
        XCTAssertEqual(mockDataManager.updatePostPost, mockPost)
    }
    
    func testDeletePost() {
        // Given
        let mockPost = TestHelper().createPostMock(mockManagedObjectContext: contextForTest)
        interactor.deletePost(post: mockPost)
        // Then
        XCTAssertTrue(mockDataManager.isDeletePostCalled)
        XCTAssertEqual(mockDataManager.deletePostPost, mockPost)
    }
}

class MockPostDetailPresenter: InteractorToPesenterPostDetailProtocol {
    func fetchDetailSuccess(author: ZemogaTest.Author?, comments: [ZemogaTest.Comment]) {
        fetchDetailSuccessAuthor = author
        fetchDetailSuccessComments = comments
    }
    
    func fetchDetailFailure(error: String) {
        
    }
    
    var fetchDetailSuccessAuthor: Author?
    var fetchDetailSuccessComments: [Comment]?
    
    func fetchDetailSuccess(author: Author, comments: [Comment]) {
        fetchDetailSuccessAuthor = author
        fetchDetailSuccessComments = comments
    }
}

class MockDataManager: DataManager {
    var isGetPostDetailsCalled = false
    var getPostDetailsPostId: Int64?
    var getPostDetailsUserId: Int64?
    var mockPostDetails: (Author, [Comment])?
    var managedObjectContext: NSManagedObjectContext?
    
    var isUpdatePostCalled = false
    var updatePostPost: Post?
    
    var isDeletePostCalled = false
    var deletePostPost: Post?
    
    override func getPostDetails(postId: Int64, userId: Int64, completion: @escaping (Author?, [Comment]) -> Void){
        isGetPostDetailsCalled = true
        getPostDetailsPostId = postId
        getPostDetailsUserId = userId
        completion(mockPostDetails?.0, mockPostDetails!.1)
    }
    
    override func update(post: Post, completion: @escaping (Bool) -> Void) {
        isUpdatePostCalled = true
        updatePostPost = post
        completion(true)
    }
    
    override func deletePost(post: Post, completion: @escaping (Bool) -> Void) {
        isDeletePostCalled = true
        deletePostPost = post
        completion(true)
    }
}



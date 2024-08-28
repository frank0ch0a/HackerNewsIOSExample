//
//  ArticleRepositoryTests.swift
//  HackerNewsExampleTests
//
//  Created by Francisco Ochoa on 28/08/2024.
//

import XCTest
@testable import HackerNewsExample
final class ArticleRepositoryTests: XCTestCase {
    
    var repository: ArticleRepository!
    var mockLocalDataSource: MockLocalDataSource!
    var mockRemoteDataSource: MockRemoteDataSource!
    
    override func setUpWithError() throws {
        mockLocalDataSource = MockLocalDataSource()
        mockRemoteDataSource = MockRemoteDataSource()
        continueAfterFailure = false
        
    }
    
    override func tearDownWithError() throws {
        mockLocalDataSource = nil
        mockRemoteDataSource = nil
        repository = nil
    }
    
    func testFetchArticlesFromRemoteSuccess() async {
        repository = mockRemoteDataSource
        mockRemoteDataSource.articlesToReturn = [Article(id: "1", title: "Remote Title", storyTitle: "Remote Story", author: "Remote Author", createdAt: "2024-08-27", articleUrl: "https://example.com")]
        
        let articles = try? await repository.fetchArticles()
        XCTAssertEqual(articles?.count, 1)
        XCTAssertEqual(articles?.first?.title, "Remote Title")
    }
    
    func testFetchArticlesFromLocalSuccess() async {
        repository = mockLocalDataSource
        mockLocalDataSource.articlesToReturn = [Article(id: "2", title: "Local Title", storyTitle: "Local Story", author: "Local Author", createdAt: "2024-08-27", articleUrl: "https://example.com")]
        
        let articles = try? await repository.fetchArticles()
        XCTAssertEqual(articles?.count, 1)
        XCTAssertEqual(articles?.first?.title, "Local Title")
    }
    
    
    func testSaveArticles() {
        repository = mockLocalDataSource
        let articles = [Article(id: "1", title: "New Title", storyTitle: "New Story", author: "New Author", createdAt: "2024-08-27", articleUrl: "https://example.com")]
        repository.saveArticles(articles)
        
        XCTAssertTrue(mockLocalDataSource.didCallSaveArticles)
        XCTAssertEqual(mockLocalDataSource.articlesToReturn.count, 1)
        XCTAssertEqual(mockLocalDataSource.articlesToReturn.first?.title, "New Title")
    }
    
    func testDeleteArticle() {
        repository = mockLocalDataSource
        let article = Article(id: "1", title: "New Title", storyTitle: "New Story", author: "New Author", createdAt: "2024-08-27", articleUrl: "https://example.com")
        mockLocalDataSource.articlesToReturn = [article]
        repository.deleteArticle(article)
        
        XCTAssertTrue(mockLocalDataSource.didCallDeleteArticle)
        XCTAssertEqual(mockLocalDataSource.articlesToReturn.count, 0)
    }
}

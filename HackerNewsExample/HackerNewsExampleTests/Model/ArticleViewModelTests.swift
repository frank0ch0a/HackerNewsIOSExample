//
//  ArticleViewModelTests.swift
//  HackerNewsExampleTests
//
//  Created by Francisco Ochoa on 27/08/2024.
//

import XCTest
@testable import HackerNewsExample

@MainActor
final class ArticleViewModelTests: XCTestCase {

    var viewModel: ArticleViewModel!
    var repository: MockArticleRepository!
    

    override func setUpWithError() throws {
        super.setUp()
        repository = MockArticleRepository()
        viewModel = ArticleViewModel(repository: repository)
     
    }

    override func tearDownWithError() throws {
        viewModel = nil
        repository = nil
        super.tearDown()
    }

    func testFetchArticlesSuccess() async {
        repository.articlesToReturn = [Article(id: "1",
                                                title: "Title",
                                                storyTitle: "Story Story Title",
                                                author: "Frank",
                                                createdAt: "2024-08-27",
                                                articleUrl: "https://example.com")]
        
        await viewModel.fetchArticles()

        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.isLoading, false)
    }

    func testFetchArticlesFailure() async {
        repository.shouldThrowError = true
        
        await viewModel.fetchArticles()

        XCTAssertEqual(viewModel.articles.count, 0)
        XCTAssertEqual(viewModel.isLoading, false)
        
    }

    func testDeleteArticle() {
        let article = Article(id: "1",
                              title: "Title",
                              storyTitle: "Story Story Title",
                              author: "Frank",
                              createdAt: "2024-08-27",
                              articleUrl: "https://example.com")
        viewModel.articles = [article]
        
        viewModel.deleteArticle(at: IndexSet(integer: 0))
        
        XCTAssertEqual(viewModel.articles.count, 0)
    }
}

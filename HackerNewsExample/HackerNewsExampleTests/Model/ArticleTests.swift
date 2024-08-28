import XCTest
@testable import HackerNewsExample

final class ArticleTests: XCTestCase {

    func testArticleInitialization() {
           let article = Article(id: "1",
                                 title: "Title",
                                 storyTitle: "Story Title",
                                 author: "Frank",
                                 createdAt: "2024-08-27",
                                 articleUrl: "https://example.com")
           
           XCTAssertEqual(article.id, "1")
           XCTAssertEqual(article.title, "Title")
           XCTAssertEqual(article.articleUrl, "https://example.com")
           XCTAssertEqual(article.storyTitle, "Story Title")
           XCTAssertEqual(article.createdAt, "2024-08-27")
           XCTAssertEqual(article.author, "Frank")
       }
}

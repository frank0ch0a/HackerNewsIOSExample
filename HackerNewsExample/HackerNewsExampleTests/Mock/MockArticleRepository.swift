import Foundation
@testable import HackerNewsExample

class MockArticleRepository: ArticleRepository {
    var articlesToReturn: [Article] = []
    var shouldThrowError = false

    func fetchArticles() async throws -> [Article] {
        if shouldThrowError {
            throw URLError(.notConnectedToInternet)
        }
        return articlesToReturn
    }
    
    func saveArticles(_ articles: [Article]) {}
    func getCachedArticles() -> [Article] { return articlesToReturn }
    func deleteArticle(_ article: Article) {}
}


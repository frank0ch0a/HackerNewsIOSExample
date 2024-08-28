import Foundation
@testable import HackerNewsExample

class MockRemoteDataSource: ArticleRepository {
    var articlesToReturn: [Article] = []
    var shouldFail = false
    
    func fetchArticles() async throws -> [Article] {
        if shouldFail {
            throw NSError(domain: "Mock Error", code: 1, userInfo: nil)
        }
        return articlesToReturn
    }
    
    func saveArticles(_ articles: [Article]) {
        // Not needed for remote data source
    }
    
    func getCachedArticles() -> [Article] {
        return []
    }
    
    func deleteArticle(_ article: Article) {
        // Not needed for remote data source
    }
}

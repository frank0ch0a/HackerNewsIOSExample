import Foundation
@testable import HackerNewsExample

class MockLocalDataSource: ArticleRepository {
    var articlesToReturn: [Article] = []
    var didCallSaveArticles = false
    var didCallDeleteArticle = false
    
    func fetchArticles() async throws -> [Article] {
        return articlesToReturn
    }
    
    func saveArticles(_ articles: [Article]) {
        didCallSaveArticles = true
        articlesToReturn = articles
    }
    
    func getCachedArticles() -> [Article] {
        return articlesToReturn
    }
    
    func deleteArticle(_ article: Article) {
        didCallDeleteArticle = true
        articlesToReturn.removeAll { $0.id == article.id }
    }
}

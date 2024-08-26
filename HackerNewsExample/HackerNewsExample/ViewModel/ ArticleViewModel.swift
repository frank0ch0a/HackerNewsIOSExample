//
//   ArticleViewMode.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import Foundation

@MainActor
class ArticleViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var errorMessage: String?

    private let fetchArticlesUseCase: FetchArticlesUseCase

    init(useRemote: Bool = true) {
        let repository = ArticleRepositoryFactory.create(useRemote: useRemote)
        self.fetchArticlesUseCase = FetchArticlesUseCase(repository: repository)
        Task {
            await fetchArticles()
        }
    }

    func fetchArticles() async {
        articles = await fetchArticlesUseCase.execute()
    }

    func deleteArticle(_ article: Article) {
        fetchArticlesUseCase.deleteArticle(article)
        articles.removeAll { $0.id == article.id }
    }
}

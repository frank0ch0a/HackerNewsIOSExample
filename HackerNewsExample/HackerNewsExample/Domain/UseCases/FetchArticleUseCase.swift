//
//  FetchArticleUseCase.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import Foundation

class FetchArticlesUseCase {
    private let repository: ArticleRepository

    init(repository: ArticleRepository) {
        self.repository = repository
    }

    func execute() async -> [Article] {
        do {
            let articles = try await repository.fetchArticles()
            repository.saveArticles(articles)
            return articles
        } catch {
            return repository.getCachedArticles()
        }
    }

    func deleteArticle(_ article: Article) {
        repository.deleteArticle(article)
    }
}

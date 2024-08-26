//
//  LocalArticleDataSource.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import Foundation

class LocalArticleDataSource: ArticleRepository {
    private let localStorageKey = "cachedArticles"

    func fetchArticles() async throws -> [Article] {
        return getCachedArticles()
    }

    func saveArticles(_ articles: [Article]) {
        if let encoded = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(encoded, forKey: localStorageKey)
        }
    }

    func getCachedArticles() -> [Article] {
        if let savedArticles = UserDefaults.standard.data(forKey: localStorageKey),
           let decodedArticles = try? JSONDecoder().decode([Article].self, from: savedArticles) {
            return decodedArticles
        }
        return []
    }

    func deleteArticle(_ article: Article) {
        var articles = getCachedArticles()
        articles.removeAll { $0.id == article.id }
        saveArticles(articles)
    }
}

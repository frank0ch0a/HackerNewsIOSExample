//
//  ArticleRepository.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import Foundation

protocol ArticleRepository {
    func fetchArticles() async throws -> [Article]
    func saveArticles(_ articles: [Article])
    func getCachedArticles() -> [Article]
    func deleteArticle(_ article: Article)
}

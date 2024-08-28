//
//  ArticleRepositoryImpl.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 26/08/2024.
//

import Foundation

class ArticleRepositoryImpl: ArticleRepository {
    private let remoteDataSource: RemoteArticleDataSource?
    private let localDataSource: LocalArticleDataSource

    init(remoteDataSource: RemoteArticleDataSource? = nil, localDataSource: LocalArticleDataSource = LocalArticleDataSource()) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func fetchArticles() async throws -> [Article] {
        if let remoteDataSource = remoteDataSource {
            do {
                let remoteArticles = try await remoteDataSource.fetchArticles()
                localDataSource.saveArticles(remoteArticles)
                return remoteArticles
            } catch {
                print("Failed to fetch articles from remote: \(error)")
                return localDataSource.fetchCachedArticles()
            }
        } else {
            return localDataSource.fetchCachedArticles()
        }
    }

    func saveArticles(_ articles: [Article]) {
        localDataSource.saveArticles(articles)
    }

    func getCachedArticles() -> [Article] {
        return localDataSource.fetchCachedArticles()
    }

    func deleteArticle(_ article: Article) {
        localDataSource.deleteArticle(article)
    }
}

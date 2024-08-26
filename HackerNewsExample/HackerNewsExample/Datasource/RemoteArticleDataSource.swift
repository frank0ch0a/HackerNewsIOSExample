//
//  RemoteArticleDataSource.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import Foundation

class RemoteArticleDataSource: ArticleRepository {
    private let networkService: NetworkService
       private let baseURL = "https://hn.algolia.com/api/v1/search_by_date?query=mobile"

       init(networkService: NetworkService = DefaultNetworkService()) {
           self.networkService = networkService
       }

       func fetchArticles() async throws -> [Article] {
           guard let url = URL(string: baseURL) else { throw URLError(.badURL) }
           let response: ArticleResponse = try await networkService.request(url: url)
           return response.hits
       }

    func saveArticles(_ articles: [Article]) {
        // Not used in remote data source
    }

    func getCachedArticles() -> [Article] {
        return []
    }

    func deleteArticle(_ article: Article) {
        // Not used in remote data source
    }
}

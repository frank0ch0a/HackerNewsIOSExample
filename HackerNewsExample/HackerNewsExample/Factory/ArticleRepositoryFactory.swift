//
//  ArticleRepositoryFactory.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import Foundation
class ArticleRepositoryFactory {
    static func create(useRemote: Bool) -> ArticleRepository {
        if useRemote {
            return ArticleRepositoryImpl(
                remoteDataSource: RemoteArticleDataSource(),
                localDataSource: LocalArticleDataSource()
            )
        } else {
           
            return ArticleRepositoryImpl(
                remoteDataSource: nil,
                localDataSource: LocalArticleDataSource()
            )
        }
    }
}

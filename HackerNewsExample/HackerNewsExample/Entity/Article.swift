//
//  Article.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import Foundation

struct ArticleResponse: Codable {
    let hits: [Article]
}

struct Article: Identifiable, Codable {
    let id: String
    let title: String?
    let otherTitle: String?
    let author: String?
    let createdAt: String?
    let articleUrl: String?

    enum CodingKeys: String, CodingKey {
        case id = "objectID"
        case title = "story_title"
        case otherTitle = "title"
        case author = "author"
        case createdAt = "created_at"
        case articleUrl = "story_url"
    }
}

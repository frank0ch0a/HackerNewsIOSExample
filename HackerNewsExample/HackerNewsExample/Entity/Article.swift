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
    let storyTitle: String?
    let author: String?
    let createdAt: String?
    let articleUrl: String?

    enum CodingKeys: String, CodingKey {
        case id = "objectID"
        case title = "title"
        case storyTitle = "story_title"
        case author = "author"
        case createdAt = "created_at"
        case articleUrl = "story_url"
    }
}

extension Article {
  
    var displayTitle: String {
        return title ?? storyTitle ?? "No Title"
    }


    var relativeTime: String {
        guard let createdAt = createdAt else { return "" }
        return Article.relativeTimeString(from: createdAt)
    }

    static func relativeTimeString(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid date"
        }

        let now = Date()
        let secondsAgo = Int(now.timeIntervalSince(date))

        let minute = 60
        let hour = 3600
        let day = 86400

        if secondsAgo < minute {
            return "now"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute)m"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour)h"
        } else if secondsAgo / hour == 1 {
            return "Yesterday"
        } else {
            return "\(secondsAgo / day)d"
        }
    }
}

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
    let createdAt: String? // Now this is a String
    let articleUrl: String?

    enum CodingKeys: String, CodingKey {
        case id = "objectID"
        case title = "title"
        case storyTitle = "story_title"
        case author = "author"
        case createdAt = "created_at"
        case articleUrl = "url"
    }
}

extension Article {
    // Computed property to get the title with a fallback to storyTitle
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
            return "Invalid date" // Handle invalid date strings
        }

        let now = Date()
        let secondsAgo = Int(now.timeIntervalSince(date))

        let minute = 60
        let hour = 3600
        let day = 86400

        if secondsAgo < minute {
            return "\(secondsAgo)s"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute)m"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour)h"
        } else {
            return "\(secondsAgo / day)d"
        }
    }
}

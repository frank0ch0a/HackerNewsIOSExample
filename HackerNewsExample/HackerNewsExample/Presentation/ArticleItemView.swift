//
//  ArticleItemView.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 27/08/2024.
//

import SwiftUI

struct ArticleItemView: View {
    
    let article: Article
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.displayTitle)
                .font(.headline)
            HStack {
                Text(article.author ?? Constants.ArticleItemConstants.unKnownAuthorString)
                Text(Constants.ArticleItemConstants.hyphen)
                Text(article.relativeTime)
            }
            .font(.subheadline)
            .foregroundColor(.gray)
        }
    }
}


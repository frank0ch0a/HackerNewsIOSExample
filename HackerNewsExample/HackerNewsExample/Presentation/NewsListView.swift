//
//  ContentView.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = ArticleViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articles) { article in
                    VStack(alignment: .leading) {
                        Text(article.displayTitle) // Use displayTitle with fallback
                            .font(.headline)
                        HStack {
                            Text(article.author ?? "Unknown author")
                            Text("-")
                            Text(article.relativeTime) // Display relative time
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Articles")
            .refreshable {
                await viewModel.fetchArticles()
            }
        }
    }
}

#Preview {
    NewsListView()
}

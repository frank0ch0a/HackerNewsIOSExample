//
//  ContentView.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ArticleViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.articles) { article in
                    NavigationLink(destination: WebView(url: article.articleUrl)) {
                        Text(((article.title ?? article.otherTitle) ?? ""))
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteArticle(article)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .refreshable {
                await viewModel.fetchArticles()
            }
            .navigationTitle("Articles")
            
        }
    }
}

#Preview {
    ContentView()
}

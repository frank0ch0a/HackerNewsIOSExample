//
//  ContentView.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel: ArticleViewModel

       init() {
           let repository = ArticleRepositoryFactory.create(useRemote: true)
           _viewModel = StateObject(wrappedValue: ArticleViewModel(repository: repository))
       }

    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(viewModel.articles, id: \.id) { article in
                        if let url = article.articleUrl,!viewModel.isOffline  {
                            NavigationLink {
                                WebView(url: url)
                            } label: {
                                ArticleItemView(article: article)
                            }
                        }else {
                            ArticleItemView(article: article)
                        }
       
                    }
                    .onDelete(perform: viewModel.deleteArticle)
                }
                .listStyle(.plain)
                .navigationTitle(Constants.HomeConstants.navBarTitle)
                .refreshable {
                    await viewModel.fetchArticles()
                }
            }
            .overlay(
                VStack {
                    if viewModel.isOffline {
                        Text(Constants.HomeConstants.offlineTitle)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
            )

            if viewModel.isLoading {
                ProgressView(Constants.HomeConstants.loadingText)
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5, anchor: .center)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchArticles()
            }
        }
    }
}

#Preview {
    NewsListView()
}

//
//   ArticleViewMode.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//

import Foundation
import Combine

@MainActor
class ArticleViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading = false
    @Published var isOffline = false



    private var repository: ArticleRepository
    private var cancellables = Set<AnyCancellable>()

    init(repository: ArticleRepository) {
        self.repository = repository
        NetworkMonitor.shared.$isConnected
                  .receive(on: DispatchQueue.main)
                  .sink { [weak self] isConnected in
                      self?.isOffline = !isConnected
                  }
                  .store(in: &cancellables)
    }

    func fetchArticles() async {
        isLoading = true
        isOffline = false

            do {
                let fetchedArticles = try await repository.fetchArticles()

                
                await MainActor.run {
                        self.articles = fetchedArticles
                        self.isLoading = false
                    }
            } catch {
           
                self.isLoading = false
    
            }
        
    }
    
    func deleteArticle(at offsets: IndexSet) {
        offsets.map { articles[$0] }.forEach { article in
            repository.deleteArticle(article)
        }
        articles.remove(atOffsets: offsets)
    }
}

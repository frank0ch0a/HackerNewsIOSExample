//
//  LocalArticleDataSource.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 24/08/2024.
//
import CoreData

class LocalArticleDataSource {
    private let context = CoreDataStack.shared.viewContext
    private let dateFormatter: DateFormatter

    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    }

    func fetchCachedArticles() -> [Article] {
        let fetchRequest: NSFetchRequest<LocalArticleEntity  > = LocalArticleEntity  .fetchRequest()
        do {
            let articleEntities = try context.fetch(fetchRequest)
            return articleEntities.map { entity in
                Article(
                    id: entity.id ?? "",
                    title: entity.title,
                    storyTitle: entity.title,
                    author: entity.author,
                    createdAt:  entity.createdAt,
                    articleUrl: entity.url
                )
            }
        } catch {
            print("Failed to fetch cached articles: \(error)")
            return []
        }
    }

    func saveArticles(_ articles: [Article]) {
        for article in articles {
            let fetchRequest: NSFetchRequest<LocalArticleEntity>   = LocalArticleEntity  .fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", article.id)
            
            if let existingArticle = try? context.fetch(fetchRequest).first {
                existingArticle.title = article.title ?? article.storyTitle
                existingArticle.url = article.articleUrl
                existingArticle.author = article.author
                existingArticle.createdAt =  article.createdAt
            } else {
                let coreDataArticle = LocalArticleEntity (context: context)
                coreDataArticle.id = article.id
                coreDataArticle.author = article.author
                coreDataArticle.title = article.title ?? article.storyTitle
                coreDataArticle.url = article.articleUrl
                coreDataArticle.createdAt = article.createdAt
            }
        }
        CoreDataStack.shared.saveContext()
    }
    
    func deleteArticle(_ article: Article) {
        let fetchRequest: NSFetchRequest<LocalArticleEntity > = LocalArticleEntity .fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", article.id)
        
        if let existingArticle = try? context.fetch(fetchRequest).first {
            context.delete(existingArticle)
            CoreDataStack.shared.saveContext()
        }
    }
}

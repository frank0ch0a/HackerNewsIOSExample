//
//  LocalArticleDataSourceTests.swift
//  HackerNewsExampleTests
//
//  Created by Francisco Ochoa on 28/08/2024.
//

import XCTest
import CoreData

@testable import HackerNewsExample

final class LocalArticleDataSourceTests: XCTestCase {
    var localArticleDataSource: LocalArticleDataSource!
    var mockPersistentContainer: NSPersistentContainer!

    override func setUpWithError() throws {
        super.setUp()
       
                mockPersistentContainer = {
                    let container = NSPersistentContainer(name: "HackerNewsExample")
                    let description = NSPersistentStoreDescription()
                    description.type = NSInMemoryStoreType
                    container.persistentStoreDescriptions = [description]
                    container.loadPersistentStores { description, error in
                        XCTAssertNil(error)
                    }
                    return container
                }()

        localArticleDataSource = LocalArticleDataSource(context: mockPersistentContainer.viewContext)
            }
    
    
    override func tearDownWithError() throws  {
            super.tearDown()
            localArticleDataSource = nil
            mockPersistentContainer = nil
        }
    
    func testDeleteArticle_RemovesArticleAndSavesToDeletedArticles() {
    
           let article = Article(id: "1", title: "Test Title", storyTitle: "Test Story", author: "Test Author", createdAt: "2024-08-27", articleUrl: "https://example.com")
           saveArticleToCoreData(article)

     
           localArticleDataSource.deleteArticle(article)

    
           let fetchRequest: NSFetchRequest<LocalArticleEntity> = LocalArticleEntity.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "id == %@", article.id)
           
           let deletedArticleFetchRequest: NSFetchRequest<DeletedArticleEntity> = DeletedArticleEntity.fetchRequest()
           deletedArticleFetchRequest.predicate = NSPredicate(format: "id == %@", article.id)

           do {
               let deletedArticle = try mockPersistentContainer.viewContext.fetch(fetchRequest).first
               XCTAssertNil(deletedArticle, "Article should be deleted from Core Data")
               
               let savedDeletedArticle = try mockPersistentContainer.viewContext.fetch(deletedArticleFetchRequest).first
               XCTAssertNotNil(savedDeletedArticle, "Deleted article ID should be saved to DeletedArticleEntity")
               XCTAssertEqual(savedDeletedArticle?.id, article.id, "The ID of the deleted article should match the article that was deleted")
           } catch {
               XCTFail("Failed to fetch articles: \(error)")
           }
       }

     
       private func saveArticleToCoreData(_ article: Article) {
           let entity = LocalArticleEntity(context: mockPersistentContainer.viewContext)
           entity.id = article.id
           entity.title = article.title
           entity.author = article.author
           entity.createdAt = article.createdAt
           entity.url = article.articleUrl

           do {
               try mockPersistentContainer.viewContext.save()
           } catch {
               XCTFail("Failed to save article: \(error)")
           }
       }
       
}

   
  


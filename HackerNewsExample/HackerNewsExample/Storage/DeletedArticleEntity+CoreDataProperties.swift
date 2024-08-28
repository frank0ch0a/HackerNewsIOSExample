//
//  DeletedArticleEntity+CoreDataProperties.swift
//  HackerNewsExampleTests
//
//  Created by Francisco Ochoa on 28/08/2024.
//
//

import Foundation
import CoreData


extension DeletedArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeletedArticleEntity> {
        return NSFetchRequest<DeletedArticleEntity>(entityName: "DeletedArticleEntity")
    }

    @NSManaged public var id: String?

}

extension DeletedArticleEntity : Identifiable {

}

//
//  LocalArticleEntity+CoreDataProperties.swift
//  HackerNewsExample
//
//  Created by Francisco Ochoa on 26/08/2024.
//
//

import Foundation
import CoreData


extension LocalArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalArticleEntity> {
        return NSFetchRequest<LocalArticleEntity>(entityName: "LocalArticleEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var author: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}

extension LocalArticleEntity : Identifiable {

}

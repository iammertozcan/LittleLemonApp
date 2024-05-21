//
//  Dish+CoreDataProperties.swift
//  LittleLemon
//
//  Created by Mert Özcan on 21.05.2024.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var price: String?
    @NSManaged public var image: String?
    @NSManaged public var title: String?

}

extension Dish : Identifiable {

}

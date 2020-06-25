//
//  Person+CoreDataProperties.swift
//  photocards
//
//  Created by Aldiyar Batyrbekov on 6/24/20.
//  Copyright © 2020 Aldiyar Batyrbekov. All rights reserved.
//
//

import Foundation
import CoreData


extension Person: Identifiable, Comparable {
    public static func < (lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var emailAddress: String?
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var phoneNumber: String?
    @NSManaged public var photoData: Data
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

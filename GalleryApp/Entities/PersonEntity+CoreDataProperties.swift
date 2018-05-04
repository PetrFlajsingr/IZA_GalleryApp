//
//  PersonEntity+CoreDataProperties.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonEntity> {
        return NSFetchRequest<PersonEntity>(entityName: "PersonEntity")
    }

    @NSManaged public var surname: String?
    @NSManaged public var photoRecords: NSSet?

}

// MARK: Generated accessors for photoRecords
extension PersonEntity {

    @objc(addPhotoRecordsObject:)
    @NSManaged public func addToPhotoRecords(_ value: PersonOnPhotoEntity)

    @objc(removePhotoRecordsObject:)
    @NSManaged public func removeFromPhotoRecords(_ value: PersonOnPhotoEntity)

    @objc(addPhotoRecords:)
    @NSManaged public func addToPhotoRecords(_ values: NSSet)

    @objc(removePhotoRecords:)
    @NSManaged public func removeFromPhotoRecords(_ values: NSSet)

}

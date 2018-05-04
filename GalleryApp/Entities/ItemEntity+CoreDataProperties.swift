//
//  ItemEntity+CoreDataProperties.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var photoRecords: NSSet?

}

// MARK: Generated accessors for photoRecords
extension ItemEntity {

    @objc(addPhotoRecordsObject:)
    @NSManaged public func addToPhotoRecords(_ value: ItemOnPhotoEntity)

    @objc(removePhotoRecordsObject:)
    @NSManaged public func removeFromPhotoRecords(_ value: ItemOnPhotoEntity)

    @objc(addPhotoRecords:)
    @NSManaged public func addToPhotoRecords(_ values: NSSet)

    @objc(removePhotoRecords:)
    @NSManaged public func removeFromPhotoRecords(_ values: NSSet)

}

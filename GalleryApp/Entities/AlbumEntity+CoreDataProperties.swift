//
//  AlbumEntity+CoreDataProperties.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//
//

import Foundation
import CoreData


extension AlbumEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AlbumEntity> {
        return NSFetchRequest<AlbumEntity>(entityName: "AlbumEntity")
    }
    
    // sets the creation date of newly inserted entity to current date
    override public func awakeFromInsert() {
        self.creationDate = NSDate()
    }

    @NSManaged public var creationDate: NSDate?
    @NSManaged public var desc: String?
    @NSManaged public var title: String?
    @NSManaged public var photos: NSSet?

}

// MARK: Generated accessors for photos
extension AlbumEntity {

    @objc(addPhotosObject:)
    @NSManaged public func addToPhotos(_ value: PhotoEntity)

    @objc(removePhotosObject:)
    @NSManaged public func removeFromPhotos(_ value: PhotoEntity)

    @objc(addPhotos:)
    @NSManaged public func addToPhotos(_ values: NSSet)

    @objc(removePhotos:)
    @NSManaged public func removeFromPhotos(_ values: NSSet)

}

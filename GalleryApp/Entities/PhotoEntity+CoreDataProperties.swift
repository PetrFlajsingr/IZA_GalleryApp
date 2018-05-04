//
//  PhotoEntity+CoreDataProperties.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//
//

import Foundation
import CoreData


extension PhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoEntity> {
        return NSFetchRequest<PhotoEntity>(entityName: "PhotoEntity")
    }

    @NSManaged public var creationDate: NSDate?
    @NSManaged public var format: String?
    @NSManaged public var imageData: NSData?
    @NSManaged public var pathToFile: String?
    @NSManaged public var title: String?
    @NSManaged public var albums: NSSet?
    @NSManaged public var itemsOnPhoto: NSSet?
    @NSManaged public var personsOnPhoto: NSSet?
    @NSManaged public var resolution: ResolutionEntity?

}

// MARK: Generated accessors for albums
extension PhotoEntity {

    @objc(addAlbumsObject:)
    @NSManaged public func addToAlbums(_ value: AlbumEntity)

    @objc(removeAlbumsObject:)
    @NSManaged public func removeFromAlbums(_ value: AlbumEntity)

    @objc(addAlbums:)
    @NSManaged public func addToAlbums(_ values: NSSet)

    @objc(removeAlbums:)
    @NSManaged public func removeFromAlbums(_ values: NSSet)

}

// MARK: Generated accessors for itemsOnPhoto
extension PhotoEntity {

    @objc(addItemsOnPhotoObject:)
    @NSManaged public func addToItemsOnPhoto(_ value: ItemOnPhotoEntity)

    @objc(removeItemsOnPhotoObject:)
    @NSManaged public func removeFromItemsOnPhoto(_ value: ItemOnPhotoEntity)

    @objc(addItemsOnPhoto:)
    @NSManaged public func addToItemsOnPhoto(_ values: NSSet)

    @objc(removeItemsOnPhoto:)
    @NSManaged public func removeFromItemsOnPhoto(_ values: NSSet)

}

// MARK: Generated accessors for personsOnPhoto
extension PhotoEntity {

    @objc(addPersonsOnPhotoObject:)
    @NSManaged public func addToPersonsOnPhoto(_ value: PersonOnPhotoEntity)

    @objc(removePersonsOnPhotoObject:)
    @NSManaged public func removeFromPersonsOnPhoto(_ value: PersonOnPhotoEntity)

    @objc(addPersonsOnPhoto:)
    @NSManaged public func addToPersonsOnPhoto(_ values: NSSet)

    @objc(removePersonsOnPhoto:)
    @NSManaged public func removeFromPersonsOnPhoto(_ values: NSSet)

}

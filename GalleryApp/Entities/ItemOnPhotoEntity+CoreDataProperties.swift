//
//  ItemOnPhotoEntity+CoreDataProperties.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//
//

import Foundation
import CoreData


extension ItemOnPhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemOnPhotoEntity> {
        return NSFetchRequest<ItemOnPhotoEntity>(entityName: "ItemOnPhotoEntity")
    }

    @NSManaged public var item: ItemEntity?
    @NSManaged public var photo: PhotoEntity?
    @NSManaged public var position: PositionEntity?

}

//
//  PersonOnPhotoEntity+CoreDataProperties.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonOnPhotoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonOnPhotoEntity> {
        return NSFetchRequest<PersonOnPhotoEntity>(entityName: "PersonOnPhotoEntity")
    }

    @NSManaged public var person: PersonEntity?
    @NSManaged public var photo: PhotoEntity?
    @NSManaged public var position: PositionEntity?

}

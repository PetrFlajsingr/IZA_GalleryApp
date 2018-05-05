//
//  ResolutionEntity+CoreDataProperties.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//
//

import Foundation
import CoreData


extension ResolutionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResolutionEntity> {
        return NSFetchRequest<ResolutionEntity>(entityName: "ResolutionEntity")
    }

    @NSManaged public var resolutionX: Int32
    @NSManaged public var resolutionY: Int32
    @NSManaged public var photo: PhotoEntity?

}

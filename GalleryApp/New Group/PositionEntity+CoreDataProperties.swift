//
//  PositionEntity+CoreDataProperties.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//
//

import Foundation
import CoreData


extension PositionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PositionEntity> {
        return NSFetchRequest<PositionEntity>(entityName: "PositionEntity")
    }

    @NSManaged public var positionX: Double
    @NSManaged public var positionY: Double

}

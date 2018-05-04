//
//  ObjectEntity+CoreDataProperties.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//
//

import Foundation
import CoreData


extension ObjectEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ObjectEntity> {
        return NSFetchRequest<ObjectEntity>(entityName: "ObjectEntity")
    }

    @NSManaged public var desc: String?
    @NSManaged public var name: String?

}

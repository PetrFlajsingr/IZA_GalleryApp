//
//  ImageDataValueTransformer.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class ImageDataValueTransformer: ValueTransformer {
    static let sizeLimit : NSSize = {
        var size = NSSize()
        
        size.width = 200
        size.height = 100
        
        return size
    }()

    override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        if(value == nil){
            return nil
        }
        let imageData : NSData = (value as! NSData)
        
        let image = NSImage(data: imageData as Data)
    
        return ImageUtils.scaleImageToFitItem(image: image!, sizeLimits: ImageDataValueTransformer.sizeLimit)
    }
}

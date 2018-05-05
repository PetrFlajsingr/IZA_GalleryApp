//
//  ResolutionValueTransformer.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class ResolutionValueTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return false
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let resolution : ResolutionEntity = (value as! ResolutionEntity?) else {
            return "0x0"
        }
        
        let stringX = String(resolution.resolutionX)
        let stringY = String(resolution.resolutionY)
        
        
        return stringX + "x" + stringY
    }
}

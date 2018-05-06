//
//  DefaultNameValueTransformer.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 06/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class DefaultNameValueTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let string = value as? String else{
            return "Name"
        }
        
        return string
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        return value as! String
    }
}

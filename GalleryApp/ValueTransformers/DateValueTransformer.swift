//
//  DateValueFormater.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 03/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Foundation

/*
 Transforms Date/NSDate to format "dd.MM.yyyy" and back, returns current date in reverse transform if value is not correct format
 */
class DateValueTransformer: ValueTransformer {
    override class func transformedValueClass() -> AnyClass {
        return NSString.self
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let date = value as! String? else{
            return Date()
        }
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        
        if let returnDate = formatter.date(from: date){
            return returnDate
        }
        
        return Date()
    }
    
    override class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    override func transformedValue(_ value: Any?) -> Any? {
        guard let date = value as! Date? else{
            return ""
        }
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter.string(for: date)
    }
}

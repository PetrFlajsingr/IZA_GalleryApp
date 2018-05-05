//
//  ImageUtils.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 05/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Foundation
import Cocoa

class ImageUtils{
    static func scaleImageToFitItem(image: NSImage, sizeLimits: NSSize) -> NSImage {
        
        var widthRatio: Float = 0.0
        var heightRatio: Float = 0.0
        let imageWidth = Float(image.size.width)
        let imageHeight = Float(image.size.height)
        let desiredWidth = Float(sizeLimits.width)
        let desiredHeight = Float(sizeLimits.height)
        
        widthRatio = desiredWidth / imageWidth;
        
        heightRatio = desiredHeight / imageHeight;
        
        let ratio = (widthRatio >= heightRatio ? heightRatio : widthRatio)
        
        // Calculate new size based on the ratio
        let newWidth = imageWidth * ratio
        let newHeight = imageHeight * ratio
        
        let imageSo = CGImageSourceCreateWithData(image.tiffRepresentation! as CFData, nil)
        let options: [NSString: NSObject] = [
            kCGImageSourceThumbnailMaxPixelSize: max(imageWidth, imageHeight) * ratio as NSObject,
            kCGImageSourceCreateThumbnailFromImageAlways: true as NSObject
        ]
        let size1 = NSSize(width: Int(newWidth), height: Int(newHeight))
        let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSo!, 0, options as CFDictionary).flatMap {
            NSImage(cgImage: $0, size: size1)
        }
        
        return scaledImage!
    }
}

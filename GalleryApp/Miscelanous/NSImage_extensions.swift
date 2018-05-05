//
//  NSImage_extensions.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 05/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Foundation
import Cocoa

extension NSImage{
    var pngData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        
        return bitmapImage.representation(using: .png, properties: [:])
    }
    func pngWrite(url: URL, options: Data.WritingOptions = .atomic) -> Bool {
        do{
            try pngData?.write(to: url, options: options)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    var jpgData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        
        return bitmapImage.representation(using: .jpeg, properties: [:])
    }
    func jpgWrite(url: URL, options: Data.WritingOptions = .atomic) -> Bool {
        do{
            try jpgData?.write(to: url, options: options)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    var bmpData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        
        return bitmapImage.representation(using: .bmp, properties: [:])
    }
    func bmpWrite(url: URL, options: Data.WritingOptions = .atomic) -> Bool {
        do{
            try bmpData?.write(to: url, options: options)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    var gifData: Data? {
        guard let tiffRepresentation = tiffRepresentation, let bitmapImage = NSBitmapImageRep(data: tiffRepresentation) else { return nil }
        
        return bitmapImage.representation(using: .gif, properties: [:])
    }
    func gifWrite(url: URL, options: Data.WritingOptions = .atomic) -> Bool {
        do{
            try gifData?.write(to: url, options: options)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    static func writePhotoEntity(entity: PhotoEntity, url: URL) -> (status: Bool, errorMessage: String){
        let pathExtention = url.pathExtension
        
        let imageData : NSData = (entity.imageData! as NSData)
        
        let image = NSImage(data: imageData as Data)
        
        var saveResult : Bool = true
        
        switch pathExtention{
        case "jpg", "jpeg":
            saveResult = (image?.jpgWrite(url: url))!
        case "png":
            saveResult = (image?.pngWrite(url: url))!
        case "bmp":
            saveResult = (image?.bmpWrite(url: url))!
        case "gif":
            saveResult = (image?.gifWrite(url: url))!
        default:
            return (false, "Unsupported file format")
        }
        
        if(!saveResult){
            return (false, "The file could not be saved")
        }
        
        return (true, "")
    }
}

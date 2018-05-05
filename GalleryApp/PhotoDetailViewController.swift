//
//  PhotoDetailViewController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class PhotoDetailViewController: NSViewController {
    @IBOutlet var PhotoObjectController: NSObjectController!
    
    @objc var MOC: NSManagedObjectContext {
        return (NSApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
    }
    
    @objc var EDI : Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let objectID = (NSApplication.shared.delegate as! AppDelegate).selectedPhoto?.objectID

        let predicate = NSPredicate(format: "SELF = %@", objectID!)
        PhotoObjectController.fetchPredicate = predicate
    }
    
    @IBOutlet weak var PhotoImageView: NSImageView!
    @IBAction func SaveToFile_OnClick(_ sender: NSButton) {
        let dialog = NSSavePanel();
        
        dialog.title                   = "Choose target file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canCreateDirectories    = true;
        dialog.allowedFileTypes        = ["jpg", "png", "jpeg", "gif", "bmp"];
        dialog.isExtensionHidden       = false;
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            
            if let url = result {
                let pathExtention = result?.pathExtension
                
                let photoEntity = PhotoObjectController.selectedObjects[0] as! PhotoEntity
                let imageData : NSData = (photoEntity.imageData as! NSData)
                
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
                    let alert = NSAlert()
                    
                    alert.messageText = "Unsupported file format"
                    alert.alertStyle = NSAlert.Style.critical
                    alert.addButton(withTitle: "OK")
                    
                    alert.runModal()
                    return
                }
                
                if(!saveResult){
                    let alert = NSAlert()
                    
                    alert.messageText = "The file could not be saved"
                    alert.alertStyle = NSAlert.Style.critical
                    alert.addButton(withTitle: "OK")
                    
                    alert.runModal()
                }
                
            }
        } else {
            return
        }
    }
}

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
}


















//
//  PhotosTableViewController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class PhotosTableViewController: NSViewController {
    @objc var MOC: NSManagedObjectContext {
        return (NSApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
    }
    @objc var EDI : Bool = true
    
    @IBOutlet var PhotoArrayController: NSArrayController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    var photoDetailWindow : PhotoDetailWindowController?
    @IBAction func PhotoTable_OnDoubleClick(_ sender: NSTableView) {
        let appDelegate = (NSApplication.shared.delegate as! AppDelegate)
        
        appDelegate.selectedPhoto = PhotoArrayController.selectedObjects[0] as? PhotoEntity
        
        photoDetailWindow = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PhotoDetailWindow")) as? PhotoDetailWindowController
        
        photoDetailWindow?.showWindow(self)
    }
    
    
    @IBAction func AddPhoto_OnClick(_ sender: NSButton) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose an image";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["jpg", "png", "jpeg", "gif", "bmp"];
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            
            if (result != nil) {
                let path = result!.path
                
                let filename = (path as NSString).lastPathComponent
                let pathExtention = result?.pathExtension
                
                let photo = NSEntityDescription.insertNewObject(forEntityName: "PhotoEntity", into: MOC) as! PhotoEntity
                
                let resolution = NSEntityDescription.insertNewObject(forEntityName: "ResolutionEntity", into: MOC) as! ResolutionEntity
                
                let image : NSImage = NSImage(byReferencingFile: path)!
                
                let imageRep = NSImageRep(contentsOfFile: path)
                
                resolution.resolutionX = Int32(imageRep!.pixelsWide)
                resolution.resolutionY = Int32(imageRep!.pixelsHigh)
                
                let fileManager = FileManager.default
                
                do {
                    let attributes = try fileManager.attributesOfItem(atPath: path) as NSDictionary
                    let creationDate = attributes.fileCreationDate()
                    photo.creationDate = creationDate! as NSDate
                }
                catch{
                    photo.creationDate = NSDate()
                }
                
                photo.imageData = image.tiffRepresentation! as NSData
                photo.title = filename
                photo.format = pathExtention
                photo.pathToFile = path
                photo.resolution = resolution
                
            }
        } else {
            return
        }
    }
}

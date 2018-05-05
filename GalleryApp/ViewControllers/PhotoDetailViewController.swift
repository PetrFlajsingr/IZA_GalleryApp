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

    var selectedPhoto : PhotoEntity?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        selectedPhoto = (view.window?.windowController as! PhotoDetailWindowController).getPhoto()
        
        let objectID = selectedPhoto?.objectID
        
        let predicate = NSPredicate(format: "SELF = %@", objectID!)
        PhotoObjectController.fetchPredicate = predicate
        
        view.window?.title = "Photo: " + (selectedPhoto?.title)!
    }
    
    @IBOutlet weak var PhotoImageView: NSImageView!
    @IBAction func SaveToFile_OnClick(_ sender: NSButton) {
        let photoEntity = PhotoObjectController.selectedObjects[0] as! PhotoEntity
        
        let dialog = NSSavePanel();
        
        dialog.title                   = "Choose target file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canCreateDirectories    = true;
        dialog.allowedFileTypes        = ["jpg", "png", "jpeg", "gif", "bmp"];
        dialog.isExtensionHidden       = false;
        dialog.nameFieldStringValue    = photoEntity.title!
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            
            if let url = result {
                DispatchQueue.global().async {
                    let saveResult = NSImage.writePhotoEntity(entity: photoEntity, url: url)
                    
                    if(!saveResult.status){
                        DispatchQueue.main.async {
                            let alert = NSAlert()
                            
                            alert.messageText = saveResult.errorMessage
                            alert.alertStyle = NSAlert.Style.critical
                            alert.addButton(withTitle: "OK")
                            
                            alert.runModal()
                        }
                    }
                }
            }
        } else {
            return
        }
    }
}

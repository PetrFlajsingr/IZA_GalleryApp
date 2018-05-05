//
//  AlbumPhotoViewController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 05/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class AlbumPhotoViewController: NSViewController {
    @objc var MOC: NSManagedObjectContext {
        return (NSApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
    }
    @objc var EDI : Bool = true
    
    var selectedAlbum : AlbumEntity?

    var addPhotosWindow : AddPhotoToAlbumWindowController?
    @IBAction func AddPhoto_OnClick(_ sender: NSButton) {
        addPhotosWindow = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "AddPhotoToAlbumWindow")) as? AddPhotoToAlbumWindowController
        
        addPhotosWindow?.showWindow(self)
    }
    
    @IBOutlet var PhotoArrayController: NSArrayController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        selectedAlbum = (NSApplication.shared.delegate as! AppDelegate).selectedAlbum
        
        let objectID = selectedAlbum?.objectID
        
        let predicate = NSPredicate(format: "SUBQUERY(albums, $album, $album = %@).@count <> 0", objectID!)
        PhotoArrayController.fetchPredicate = predicate
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadArrayController), name: NSNotification.Name(rawValue: "reloadPhotosInAlbum"), object: nil)
        
        view.window?.title = "Album: " + (selectedAlbum?.title)!
    }
    
    @objc func reloadArrayController(){
        do{
            try PhotoArrayController.fetch(with: nil, merge: true)
        }
        catch{}
    }
    
    
    @IBAction func RemovePhotoFromAlbum_OnClick(_ sender: NSButton) {
        let photoToRemove = PhotoArrayController.selectedObjects[0] as! PhotoEntity
        
        selectedAlbum?.removeFromPhotos(photoToRemove)
        
        reloadArrayController()
    }
    
    @IBAction func SaveAllImages_OnClick(_ sender: NSButton) {
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose target folder";
        dialog.canChooseDirectories    = true;
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canCreateDirectories    = true;
        dialog.isExtensionHidden       = false;
        dialog.canChooseFiles          = false;
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            
            if let url = result {
                for photoEntity in PhotoArrayController.arrangedObjects as! [PhotoEntity] {
                    let filepathUrl = URL(string: url.absoluteString + "/" + photoEntity.title! + "." + photoEntity.format!)!
                    
                    let imageData : NSData = (photoEntity.imageData! as NSData)
                    
                    let image = NSImage(data: imageData as Data)
                    
                    let pathExtension = photoEntity.format
                    
                    var saveResult : Bool = true
                    
                    switch pathExtension{
                    case "jpg", "jpeg":
                        saveResult = (image?.jpgWrite(url: filepathUrl))!
                    case "png":
                        saveResult = (image?.pngWrite(url: filepathUrl))!
                    case "bmp":
                        saveResult = (image?.bmpWrite(url: filepathUrl))!
                    case "gif":
                        saveResult = (image?.gifWrite(url: filepathUrl))!
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
            }
        } else {
            return
        }
    }
    
    var photoDetailWindow : PhotoDetailWindowController?
    @IBAction func PhotoTable_OnDoubleClick(_ sender: NSTableView) {
        let appDelegate = (NSApplication.shared.delegate as! AppDelegate)
        
        appDelegate.selectedPhoto = PhotoArrayController.selectedObjects[0] as? PhotoEntity
        
        photoDetailWindow = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PhotoDetailWindow")) as? PhotoDetailWindowController
        
        photoDetailWindow?.showWindow(self)
    }
}












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
        
        addPhotosWindow?.setAlbum(albumEntity: selectedAlbum!)
        
        addPhotosWindow?.showWindow(self)
    }
    
    @IBOutlet var PhotoArrayController: NSArrayController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadArrayController), name: NSNotification.Name(rawValue: "reloadPhotosInAlbum"), object: nil)
    }
    
    override func viewWillAppear() {
        selectedAlbum = (view.window?.windowController as! AlbumPhotoWindow).getAlbum()
        
        let objectID = selectedAlbum?.objectID
        
        let predicate = NSPredicate(format: "SUBQUERY(albums, $album, $album = %@).@count <> 0", objectID!)
        PhotoArrayController.fetchPredicate = predicate
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
                    
                    DispatchQueue.global().async {
                        let saveResult = NSImage.writePhotoEntity(entity: photoEntity, url: filepathUrl)
                        
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
            }
        } else {
            return
        }
    }
    
    var photoDetailWindow : PhotoDetailWindowController?
    @IBAction func PhotoTable_OnDoubleClick(_ sender: NSTableView) {
        photoDetailWindow = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PhotoDetailWindow")) as? PhotoDetailWindowController
        
        photoDetailWindow?.setPhoto(photoEntity: (PhotoArrayController.selectedObjects[0] as? PhotoEntity)!)
        
        photoDetailWindow?.showWindow(self)
    }
}












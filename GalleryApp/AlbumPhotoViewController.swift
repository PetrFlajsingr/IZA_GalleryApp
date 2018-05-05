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
    
    var photoDetailWindow : PhotoDetailWindowController?
    @IBAction func PhotoTable_OnDoubleClick(_ sender: NSTableView) {
        let appDelegate = (NSApplication.shared.delegate as! AppDelegate)
        
        appDelegate.selectedPhoto = PhotoArrayController.selectedObjects[0] as? PhotoEntity
        
        photoDetailWindow = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PhotoDetailWindow")) as? PhotoDetailWindowController
        
        photoDetailWindow?.showWindow(self)
    }
}












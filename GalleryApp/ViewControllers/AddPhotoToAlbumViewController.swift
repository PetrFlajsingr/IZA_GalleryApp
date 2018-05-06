//
//  AddPhotoToAlbumViewController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 05/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class AddPhotoToAlbumViewController: NSViewController {
    @objc var MOC: NSManagedObjectContext {
        return (NSApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
    }
    @objc var EDI : Bool = true
    
    var selectedAlbum : AlbumEntity?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        selectedAlbum = (view.window?.windowController as! AddPhotoToAlbumWindowController).getAlbum()
        
        let objectID = selectedAlbum?.objectID
        
        let predicate = NSPredicate(format: "SUBQUERY(albums, $album, $album = %@).@count = 0", objectID!)
        PhotosArrayController.fetchPredicate = predicate
    }
    
    @IBOutlet var PhotosArrayController: NSArrayController!
    @IBAction func AddPhotoToAlbum_DoubleClick(_ sender: NSTableView) {
        let photoToAdd = PhotosArrayController.selectedObjects[0] as! PhotoEntity
        
        selectedAlbum?.addToPhotos(photoToAdd)

        view.window?.windowController?.close()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadPhotosInAlbum"), object: nil)
    }
}

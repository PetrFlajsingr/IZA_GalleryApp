//
//  AddObjectViewController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 05/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class AddObjectViewController: NSViewController {
    @objc var MOC: NSManagedObjectContext {
        return (NSApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
    }
    
    @objc var EDI : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var ObjectArrayController: NSArrayController!
    
    var selectedPhoto: PhotoEntity?
    override func viewWillAppear() {
        selectedPhoto = (view.window?.windowController as! AddObjectPersonWindowController).getPhoto()
        
        let objectID = selectedPhoto?.objectID
        
        let predicate = NSPredicate(format: "SUBQUERY(photoRecords, $photoRecord, $photoRecord.photo = %@).@count = 0", objectID!)
        ObjectArrayController.fetchPredicate = predicate
    }
    
    
    @IBAction func AddObject_DoubleClick(_ sender: NSTableView) {
        let itemOnPhoto = NSEntityDescription.insertNewObject(forEntityName: "ItemOnPhotoEntity", into: MOC) as! ItemOnPhotoEntity
        
        let position = NSEntityDescription.insertNewObject(forEntityName: "PositionEntity", into: MOC) as! PositionEntity
        
        position.positionX = 0.0
        position.positionY = 0.0
        
        itemOnPhoto.item = (ObjectArrayController.selectedObjects[0] as! ItemEntity)
        itemOnPhoto.photo = selectedPhoto
        itemOnPhoto.position = position
        
        self.view.window?.close()
    }
}

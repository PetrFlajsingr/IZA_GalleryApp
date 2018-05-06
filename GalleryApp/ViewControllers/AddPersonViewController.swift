//
//  AddPersonViewController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 05/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class AddPersonViewController: NSViewController {
    @objc var MOC: NSManagedObjectContext {
        return (NSApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
    }
    
    @objc var EDI : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet var PersonArrayController: NSArrayController!
    
    var selectedPhoto: PhotoEntity?
    override func viewWillAppear() {
        selectedPhoto = (view.window?.windowController as! AddObjectPersonWindowController).getPhoto()
        
        let objectID = selectedPhoto?.objectID
        
        let predicate = NSPredicate(format: "SUBQUERY(photoRecords, $photoRecord, $photoRecord.photo = %@).@count = 0", objectID!)
        PersonArrayController.fetchPredicate = predicate
    }
    @IBAction func AddPerson_DoubleClick(_ sender: NSTableView) {
        let personOnPhoto = NSEntityDescription.insertNewObject(forEntityName: "PersonOnPhotoEntity", into: MOC) as! PersonOnPhotoEntity
        
        let position = NSEntityDescription.insertNewObject(forEntityName: "PositionEntity", into: MOC) as! PositionEntity
        
        position.positionX = 0.0
        position.positionY = 0.0
        
        personOnPhoto.person = (PersonArrayController.selectedObjects[0] as! PersonEntity)
        personOnPhoto.photo = selectedPhoto
        personOnPhoto.position = position
        
        self.view.window?.close()
    }
}

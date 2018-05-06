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
        // Do view setup here.
    }
    
    @IBOutlet var ObjectArrayController: NSArrayController!
    
    var selectedPhoto: PhotoEntity?
    override func viewWillAppear() {
        selectedPhoto = (view.window?.windowController as! AddObjectPersonWindowController).getPhoto()
        
        let objectID = selectedPhoto?.objectID
        
        let predicate = NSPredicate(format: "SUBQUERY(photoRecords, $photoRecord, $photoRecord.photo = %@).@count = 0", objectID!)
        ObjectArrayController.fetchPredicate = predicate
    }
}

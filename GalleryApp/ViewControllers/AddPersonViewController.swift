//
//  AddPersonViewController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 05/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class AddPersonViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBOutlet var PersonArrayController: NSArrayController!
    
    var selectedPhoto: PhotoEntity?
    override func viewWillAppear() {
        selectedPhoto = (view.window?.windowController as! AddObjectPersonWindowController).getPhoto()
        
        let objectID = selectedPhoto?.objectID
        
        let predicate = NSPredicate(format: "SUBQUERY(photoRecords, $photoRecord, $photoRecord.photo = %@).@count = 0", objectID!)
        PersonArrayController.fetchPredicate = predicate
    }
}

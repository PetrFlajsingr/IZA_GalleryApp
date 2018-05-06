//
//  PeopleViewController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class PeopleViewController: NSViewController {

    @IBOutlet var PeopleArrayController: NSArrayController!
    
    @objc var MOC: NSManagedObjectContext {
        return (NSApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
    }
    
    @objc var EDI : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        let selectedPerson = PeopleArrayController.selectedObjects[0] as! PersonEntity
        
        let objectID = selectedPerson.objectID
        
        setPredicateForPhotosArrayController(personID: objectID)
    }
    
    @IBAction func People_OnSelectionChanged(_ sender: NSTableView) {
        if(PeopleArrayController.selectedObjects.count != 1){
            setPredicateForPhotosArrayController(personID: NSManagedObjectID())
            return
        }
        
        let selectedPerson = PeopleArrayController.selectedObjects[0] as! PersonEntity
        
        let objectID = selectedPerson.objectID
        
        setPredicateForPhotosArrayController(personID: objectID)
    }
    
    @IBOutlet var PhotosArrayController: NSArrayController!
    func setPredicateForPhotosArrayController(personID: NSManagedObjectID){
        let predicate = NSPredicate(format: "SUBQUERY(personsOnPhoto, $personOnPhoto, $personOnPhoto.person = %@).@count <> 0", personID)
        
        PhotosArrayController.fetchPredicate = predicate
    }
}

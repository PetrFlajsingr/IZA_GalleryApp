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
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        if(PeopleArrayController.selectedObjects.count == 0){
            return
        }
        
        let selectedPerson = PeopleArrayController.selectedObjects[0] as! PersonEntity
        
        let objectID = selectedPerson.objectID
        
        setPredicateForPhotosArrayController(personID: objectID)
    }
    
    @IBAction func People_OnSelectionChanged(_ sender: NSTableView) {
        if(PeopleArrayController.selectedObjects.count == 0){
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
    
    var photoDetailWindow: PhotoDetailWindowController?
    /*
     Creates and shows window containing photo detail
     */
    @IBAction func Photos_OnDoubleClick(_ sender: NSTableView) {
        if(PhotosArrayController.selectedObjects.count == 0){
            return
        }
        
        photoDetailWindow = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "PhotoDetailWindow")) as? PhotoDetailWindowController
        
        photoDetailWindow?.setPhoto(photoEntity: (PhotosArrayController.selectedObjects[0] as? PhotoEntity)!)
        
        photoDetailWindow?.showWindow(self)
    }
}

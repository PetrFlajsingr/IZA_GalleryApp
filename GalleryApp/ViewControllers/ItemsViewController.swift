//
//  ItemsViewController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class ItemsViewController: NSViewController {
    
    @IBOutlet var ItemsArrayController: NSArrayController!
    
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
        
        let selectedItem = ItemsArrayController.selectedObjects[0] as! ItemEntity
        
        let objectID = selectedItem.objectID
        
        setPredicateForPhotosArrayController(itemID: objectID)
    }
    
    @IBOutlet var PhotosArrayController: NSArrayController!
    @IBAction func Objects_SelectionChanged(_ sender: NSTableView) {
        if(ItemsArrayController.selectedObjects.count != 1){
            setPredicateForPhotosArrayControllerToShowNothing()
            return
        }
        
        let selectedItem = ItemsArrayController.selectedObjects[0] as! ItemEntity
        
        let objectID = selectedItem.objectID
        
        setPredicateForPhotosArrayController(itemID: objectID)
    }
    
    func setPredicateForPhotosArrayControllerToShowNothing(){
        let predicate = NSPredicate(format: "SELF = _")
        
        PhotosArrayController.fetchPredicate = predicate
    }
    
    func setPredicateForPhotosArrayController(itemID: NSManagedObjectID){
        let predicate = NSPredicate(format: "SUBQUERY(itemsOnPhoto, $itemOnPhoto, $itemOnPhoto.item = %@).@count <> 0", itemID)
        
        PhotosArrayController.fetchPredicate = predicate
    }
}

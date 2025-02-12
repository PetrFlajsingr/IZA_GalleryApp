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
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        if(ItemsArrayController.selectedObjects.count == 0){
            return
        }
        
        let selectedItem = ItemsArrayController.selectedObjects[0] as! ItemEntity
        
        let objectID = selectedItem.objectID
        
        setPredicateForPhotosArrayController(itemID: objectID)
    }
    
    @IBOutlet var PhotosArrayController: NSArrayController!
    @IBAction func Objects_SelectionChanged(_ sender: NSTableView) {
        if(ItemsArrayController.selectedObjects.count == 0){
            return
        }
        
        let selectedItem = ItemsArrayController.selectedObjects[0] as! ItemEntity
        
        let objectID = selectedItem.objectID
        
        setPredicateForPhotosArrayController(itemID: objectID)
    }
    
    func setPredicateForPhotosArrayController(itemID: NSManagedObjectID){
        let predicate = NSPredicate(format: "SUBQUERY(itemsOnPhoto, $itemOnPhoto, $itemOnPhoto.item = %@).@count <> 0", itemID)
        
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

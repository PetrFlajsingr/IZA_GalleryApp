//
//  PhotoDetailViewController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class PhotoDetailViewController: NSViewController {
    @IBOutlet var PhotoObjectController: NSObjectController!
    
    @objc var MOC: NSManagedObjectContext {
        return (NSApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
    }
    
    @objc var EDI : Bool = true

    var selectedPhoto : PhotoEntity?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        selectedPhoto = (view.window?.windowController as! PhotoDetailWindowController).getPhoto()
        
        let objectID = selectedPhoto?.objectID
        
        let predicate = NSPredicate(format: "SELF = %@", objectID!)
        PhotoObjectController.fetchPredicate = predicate
        
        setPredicateForPeopleArrayController(photoID: objectID!)
        
        setPredicateForObjectArrayController(photoID: objectID!)
        
        view.window?.title = "Photo: " + (selectedPhoto?.title)!
    }
    
    @IBOutlet weak var PhotoImageView: NSImageView!
    @IBAction func SaveToFile_OnClick(_ sender: NSButton) {
        let photoEntity = PhotoObjectController.selectedObjects[0] as! PhotoEntity
        
        let dialog = NSSavePanel();
        
        dialog.title                   = "Choose target file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canCreateDirectories    = true;
        dialog.allowedFileTypes        = ["jpg", "png", "jpeg", "gif", "bmp"];
        dialog.isExtensionHidden       = false;
        dialog.nameFieldStringValue    = photoEntity.title!
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url
            
            if let url = result {
                DispatchQueue.global().async {
                    let saveResult = NSImage.writePhotoEntity(entity: photoEntity, url: url)
                    
                    if(!saveResult.status){
                        DispatchQueue.main.async {
                            let alert = NSAlert()
                            
                            alert.messageText = saveResult.errorMessage
                            alert.alertStyle = NSAlert.Style.critical
                            alert.addButton(withTitle: "OK")
                            
                            alert.runModal()
                        }
                    }
                }
            }
        } else {
            return
        }
    }
    
    var addObjectsWindow: AddObjectPersonWindowController?
    @IBAction func AddPersonObject_OnClick(_ sender: NSButton) {
        addObjectsWindow = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "AddObjectPersonWindow")) as? AddObjectPersonWindowController
        
        addObjectsWindow?.setPhoto(photoEntity: selectedPhoto!)
        
        addObjectsWindow?.showWindow(self)
    }
    
    @IBOutlet var PeopleArrayController: NSArrayController!
    
    func setPredicateForPeopleArrayController(photoID: NSManagedObjectID){
        let predicate = NSPredicate(format: "SUBQUERY(photoRecords, $record, $record.photo = %@).@count <> 0", photoID)
        
        PeopleArrayController.fetchPredicate = predicate
    }
    
    @IBOutlet var ObjectsArrayController: NSArrayController!
    
    func setPredicateForObjectArrayController(photoID: NSManagedObjectID){
        let predicate = NSPredicate(format: "SUBQUERY(photoRecords, $record, $record.photo = %@).@count <> 0", photoID)
        
        ObjectsArrayController.fetchPredicate = predicate
    }
    @IBOutlet weak var ObjectsTable: NSTableView!
    @IBOutlet weak var PeopleTable: NSTableView!
    
    @IBAction func RemoveObjectOrPerson_OnClick(_ sender: NSButton) {
        selectedPhoto = (view.window?.windowController as! PhotoDetailWindowController).getPhoto()
        
        let objectID = selectedPhoto?.objectID
        
        if(ObjectsTable.isAccessibilityFocused()){
            let object = ObjectsArrayController.selectedObjects[0] as! ItemEntity
            
            let records = object.photoRecords
            
            var recordToRemove: ItemOnPhotoEntity? = nil
            for record in records!{
                if((record as! ItemOnPhotoEntity).photo?.objectID == objectID){
                    recordToRemove = record as? ItemOnPhotoEntity
                    break;
                }
            }
            
            if(recordToRemove == nil){
                return
            }
            
            object.removeFromPhotoRecords(recordToRemove!)
            selectedPhoto?.removeFromItemsOnPhoto(recordToRemove!)
        }else if(PeopleTable.isAccessibilityFocused()){
            let person = PeopleArrayController.selectedObjects[0] as! PersonEntity
            
            let records = person.photoRecords
            
            var recordToRemove: PersonOnPhotoEntity? = nil
            for record in records!{
                if((record as! PersonOnPhotoEntity).photo?.objectID == objectID){
                    recordToRemove = record as? PersonOnPhotoEntity
                    break;
                }
            }
            
            if(recordToRemove == nil){
                return
            }
            
            person.removeFromPhotoRecords(recordToRemove!)
            selectedPhoto?.removeFromPersonsOnPhoto(recordToRemove!)
        }
    }
    
}

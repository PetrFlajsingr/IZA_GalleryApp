//
//  AlbumListViewController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 03/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class AlbumListViewController: NSViewController {
    @IBOutlet var AlbumListArrayController: NSArrayController!

    @IBOutlet weak var AlbumListTableView: NSTableView!
    
    @IBOutlet weak var AlbumListSearchField: NSSearchField!
    
    @objc var MOC: NSManagedObjectContext {
        return (NSApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
    }
    
    @objc var EDI : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var albumPhotoWindow : AlbumPhotoWindow?
    /*
     Creates and shows window containing all photos in album
     */
    @IBAction func AlbumTable_OnDoubleClick(_ sender: NSTableView) {
        if(AlbumListArrayController.selectedObjects.count == 0){
            return
        }
        
        albumPhotoWindow = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "AlbumPhotoWindow")) as? AlbumPhotoWindow
        
        albumPhotoWindow?.setAlbum(albumEntity: (AlbumListArrayController.selectedObjects[0] as? AlbumEntity)!);
        
        albumPhotoWindow?.showWindow(self)
    }
}

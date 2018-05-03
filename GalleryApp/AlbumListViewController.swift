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

    @IBOutlet weak var AlbumListSearchField: NSSearchField!
    
    @objc var MOC: NSManagedObjectContext {
        return (NSApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
    }
    
    @objc var EDI : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}

//
//  PhotoCollectionViewItem.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class PhotoCollectionViewItem: NSCollectionViewItem {
    @objc var MOC: NSManagedObjectContext {
        return (NSApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
    }
    
    @objc var EDI : Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.xs
    }
    @IBAction func Detail_OnClick(_ sender: Any) {
        
    }
    @IBAction func Delete(_ sender: NSButton) {
        print(representedObject)
    }
    
    @IBAction func Delete_OnClick(_ sender: Any) {
    }
}

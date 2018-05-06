//
//  AddObjectPersonWindowController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 05/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class AddObjectPersonWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
    }

    private var selectedPhoto: PhotoEntity?
    
    func setPhoto(photoEntity: PhotoEntity){
        selectedPhoto = photoEntity
        
        self.window?.title = "Add objects to photo: " + (selectedPhoto?.title)!
    }
    
    func getPhoto() -> PhotoEntity{
        return selectedPhoto!
    }
}

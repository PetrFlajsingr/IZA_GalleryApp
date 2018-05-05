//
//  PhotoDetailWindowController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 04/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class PhotoDetailWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

    private var selectedPhoto: PhotoEntity?
    
    func setPhoto(photoEntity: PhotoEntity){
        selectedPhoto = photoEntity
    }
    
    func getPhoto() -> PhotoEntity{
        return selectedPhoto!
    }
}

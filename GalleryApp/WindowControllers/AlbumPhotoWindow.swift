//
//  AlbumPhotoWindow.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 05/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class AlbumPhotoWindow: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    private var selectedAlbum: AlbumEntity?
    
    func setAlbum(albumEntity: AlbumEntity){
        selectedAlbum = albumEntity
    }

    func getAlbum() -> AlbumEntity{
        return selectedAlbum!
    }
}

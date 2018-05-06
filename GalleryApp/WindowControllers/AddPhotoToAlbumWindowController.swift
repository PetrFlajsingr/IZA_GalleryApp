//
//  AddPhotoToAlbumWindowController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 05/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

class AddPhotoToAlbumWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
    }

    private var selectedAlbum: AlbumEntity?
    
    func setAlbum(albumEntity: AlbumEntity){
        selectedAlbum = albumEntity
        
        self.window?.title = "Add photos to album: " + (selectedAlbum?.title)!
    }
    
    func getAlbum() -> AlbumEntity{
        return selectedAlbum!
    }
}

//
//  SelectionBindingArrayController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 06/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

/*
An attempt to create a bindable selected object from NSArrayController - doesn't update tho...
*/
class SelectionBindingArrayController: NSArrayController {
    @objc var selectedObject: Any!{
        get {
            if(selectedObjects.count == 0){
                return nil
            }
            return self.selectedObjects[0]
        }
    }
}

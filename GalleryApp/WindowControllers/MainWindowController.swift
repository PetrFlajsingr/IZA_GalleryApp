//
//  MainWindowController.swift
//  GalleryApp
//
//  Created by Petr Flajsingr on 06/05/2018.
//  Copyright © 2018 VUT FIT. All rights reserved.
//

import Cocoa

/*
 This class exists because app delegate's first method is called too late to register certain value transformers...
 */
class MainWindowController: NSWindowController {

    override func windowWillLoad() {
        ValueTransformer.setValueTransformer(DefaultTitleValueTransformer(), forName: NSValueTransformerName(rawValue: "DefaultTitleValueTransformer"))
        
        ValueTransformer.setValueTransformer(DefaultNameValueTransformer(), forName: NSValueTransformerName(rawValue: "DefaultNameValueTransformer"))
    }
    override func windowDidLoad() {
        super.windowDidLoad()
    }

}

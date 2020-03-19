//
//  MainWindowController.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 01.12.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.title = "Coverage Dirs"
        self.window?.tabbingMode = .disallowed

        let toolbar = NSToolbar(identifier: "mainToolbar")
        toolbar.allowsUserCustomization = false
        toolbar.delegate = self
        self.window?.toolbar = toolbar
    }

}

extension MainWindowController: NSToolbarDelegate {
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar)
        -> [NSToolbarItem.Identifier] {
        return [
        .flexibleSpace,
        .separator,
        .space,
        .toggleSidebar
        ]
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar)
        -> [NSToolbarItem.Identifier] {
        return [
        .toggleSidebar
        ]
    }

    func toolbar(_ toolbar: NSToolbar,
                 itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
                 willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        return NSToolbarItem(itemIdentifier: itemIdentifier)
    }
}

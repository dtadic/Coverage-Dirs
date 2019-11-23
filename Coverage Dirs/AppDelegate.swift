//
//  AppDelegate.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.

        let jsonURL = Bundle.main.url(forResource: "test", withExtension: "json")!
        let jsonData = (try? Data(contentsOf: jsonURL))!
        let jsonString = String(data: jsonData, encoding: .utf8)
        let data = try? XCCovParser.parse(jsonString: jsonString!)

        var contentView = MainView(targets: data!, selectedTarget: nil)

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView, .unifiedTitleAndToolbar],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.titleVisibility = .hidden
        window.toolbar = NSToolbar(identifier: "toolbar")
        window.toolbar?.insertItem(withItemIdentifier: .toggleSidebar, at: 0)
        window.toolbar?.insertItem(withItemIdentifier: .flexibleSpace, at: 1)
        window.toolbar?.insertItem(withItemIdentifier: .cloudSharing, at: 2)
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

}

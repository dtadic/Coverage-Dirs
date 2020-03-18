//
//  DragView.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 18.03.20.
//  Copyright © 2020 Dušan Tadić. All rights reserved.
//

import Cocoa

@objc protocol DragViewDelegate {
    func dragViewDidReceive(fileURLs: [URL])
}

class DragView: NSView {

    @IBOutlet weak var delegate: DragViewDelegate?
    let fileExtensions = ["xcresult"]

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        color(to: .clear)
        registerForDraggedTypes([.fileURL])
    }

    override func draggingEntered(_ draggingInfo: NSDraggingInfo) -> NSDragOperation {
        var containsMatchingFiles = false
        draggingInfo
            .draggingPasteboard
            .readObjects(forClasses: [NSURL.self], options: nil)?.forEach { eachObject in
            if let eachURL = eachObject as? URL {
                containsMatchingFiles = containsMatchingFiles ||
                    fileExtensions.contains(eachURL.pathExtension.lowercased())
                if containsMatchingFiles { print(eachURL.path) }
            }
        }

        switch containsMatchingFiles {
        case true:
            color(to: .secondaryLabelColor)
            return .copy
        case false:
            color(to: .disabledControlTextColor)
            return .init()
        }
    }

    override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {
        // Collect URLs.
        var matchingFileURLs: [URL] = []
        draggingInfo.draggingPasteboard
            .readObjects(forClasses: [NSURL.self], options: nil)?.forEach { eachObject in
            if
                let eachURL = eachObject as? URL,
                fileExtensions.contains(eachURL.pathExtension.lowercased())
            { matchingFileURLs.append(eachURL) }
        }

        // Only if any,
        guard matchingFileURLs.count > 0
        else { return false }

        // Pass to delegate.
        delegate?.dragViewDidReceive(fileURLs: matchingFileURLs)
        return true
    }

    override func draggingExited(_ sender: NSDraggingInfo?) {
        color(to: .clear)
    }

    override func draggingEnded(_ sender: NSDraggingInfo) {
        color(to: .clear)
    }

}

extension DragView {

    func color(to color: NSColor) {
        self.wantsLayer = true
        self.layer?.backgroundColor = color.cgColor
    }
}

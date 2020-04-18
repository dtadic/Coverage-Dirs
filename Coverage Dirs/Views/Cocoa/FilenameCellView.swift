//
//  FilenameCellView.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 06.12.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Cocoa
import TinyConstraints

private let fileTypeIconCache = NSCache<NSString, NSImage>()

class FilenameCellView: NSTableCellView {

    var filename: String? {
        didSet {
            self.setData()
        }
    }

    private func setData() {
        self.imageView?.image = self.getIcon()

        textField?.stringValue = self.filename ?? ""
        textField?.cell?.truncatesLastVisibleLine = true
    }

    private func getIcon() -> NSImage? {
        guard let filename = self.filename else {
            return nil
        }

        if filename.contains("."),
            let type = filename.split(separator: ".").last {
            if let icon = fileTypeIconCache.object(forKey: type as NSString) {
                return icon
            }
            let icon = NSWorkspace.shared.icon(forFileType: String(type))
            icon.size = NSSize(width: 16, height: 16)
            fileTypeIconCache.setObject(icon, forKey: type as NSString)
            return icon
        } else {
            let icon = NSImage(named: NSImage.folderName)
            icon?.size = NSSize(width: 16, height: 16)
            return icon
        }
    }

}

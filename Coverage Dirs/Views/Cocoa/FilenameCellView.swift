//
//  FilenameCellView.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 06.12.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Cocoa
import TinyConstraints

class FilenameCellView: NSView {

    private let iconView = NSImageView()
    private let textView = NSTextField()

    var filename: String? {
        didSet {
            self.setData()
        }
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        self.addSubview(iconView)
        self.addSubview(textView)

        iconView.leading(to: self, offset: 5)
        iconView.centerYToSuperview()
        iconView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        iconView.setCompressionResistance(.defaultHigh, for: .horizontal)
        iconView.size(CGSize(width: 16, height: 16))

        textView.trailing(to: self)
        textView.centerYToSuperview()
        textView.topToSuperview(relation: .equalOrGreater)
        textView.bottomToSuperview(relation: .equalOrLess)
        textView.leadingToTrailing(of: iconView, offset: 5)

        self.setData()
    }

    convenience init() {
        self.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setData() {
        self.iconView.image = self.getIcon()
        textView.drawsBackground = false
        textView.isBezeled = false
        textView.isEditable = false

        textView.stringValue = self.filename ?? ""
        textView.cell?.truncatesLastVisibleLine = true
    }

    private func getIcon() -> NSImage? {
        guard let filename = self.filename else {
            return nil
        }

        if filename.contains("."),
            let type = filename.split(separator: ".").last {
            let icon = NSWorkspace.shared.icon(forFileType: String(type))
            icon.size = NSSize(width: 16, height: 16)
            return icon
        } else {
            let icon = NSImage(named: NSImage.folderName)
            icon?.size = NSSize(width: 16, height: 16)
            return icon
        }
    }

}

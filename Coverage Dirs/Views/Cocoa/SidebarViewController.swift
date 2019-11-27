//
//  SidebarViewController.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 24.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Cocoa

class SidebarViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!

    weak var delegate: SidebarViewControllerDelegate?

    var targets: [CoverageTarget] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self

//        self.tableView.selectionHighlightStyle = .none
    }

}

extension SidebarViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.targets.count
    }

    func tableView(_ tableView: NSTableView,
                   objectValueFor tableColumn: NSTableColumn?,
                   row: Int) -> Any? {
        return self.targets[row].name
    }

    func tableView(_ tableView: NSTableView,
                   viewFor tableColumn: NSTableColumn?,
                   row: Int) -> NSView? {

        let item = self.targets[row]

        return NSSidebarItemView(text: item.name,
            image: NSImage(named: "archive") ?? NSImage())
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 35
    }

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        if self.tableView.selectedRow < 0 {
            return
        }
        self.delegate?.sidebarDidSelect(target: self.targets[self.tableView.selectedRow])

        let rowView = self.tableView.rowView(atRow: self.tableView.selectedRow,
                                             makeIfNecessary: false)
        rowView?.selectionHighlightStyle = .regular
        rowView?.isEmphasized = false

    }

    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        return SidebarRowView()
    }

}

protocol SidebarViewControllerDelegate: AnyObject {
    func sidebarDidSelect(target: CoverageTarget)
}

private class SidebarRowView: NSTableRowView {
    override func drawSelection(in dirtyRect: NSRect) {
        if self.selectionHighlightStyle != .none {
            NSColor.textColor.withAlphaComponent(0.1).setFill()
            dirtyRect.fill()
        }
    }
}

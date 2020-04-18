//
//  CoverageViewController.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 24.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Cocoa
import SwiftUI

class CoverageViewController: NSViewController {
    @IBOutlet weak var outlineView: NSOutlineView!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!

    var rootDirectory: CoverageDirectory? {
        didSet {
            self.outlineView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.outlineView.dataSource = self
        self.outlineView.delegate = self
    }

    func showLoading() {
        self.progressIndicator.startAnimation(self)
    }

    func hideLoading() {
        self.progressIndicator.stopAnimation(self)
    }
}

extension CoverageViewController: NSOutlineViewDataSource, NSOutlineViewDelegate {

    func outlineView(_ outlineView: NSOutlineView,
                     child index: Int,
                     ofItem item: Any?) -> Any {

        if item == nil,
            let item = self.rootDirectory {
            var subItems = (item.children as [Any])
            subItems.append(contentsOf: item.files)
            return subItems[index]
        }

        guard let item = item as? CoverageDirectory else {
            fatalError("Item should be directory")
        }

        var subItems = (item.children as [Any])
        subItems.append(contentsOf: item.files)

        return subItems[index]
    }

    func outlineView(_ outlineView: NSOutlineView,
                     sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
        guard let sort = self.outlineView.sortDescriptors.first,
            let key = sort.key else {
            return
        }

        self.rootDirectory?.sort(by: key, ascending: sort.ascending)
        self.outlineView.reloadData()
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {

        guard let item = item as? CoverageDirectory else {
            return false
        }

        return !item.children.isEmpty || !item.files.isEmpty
    }

    func outlineView(_ outlineView: NSOutlineView,
                     numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return (self.rootDirectory?.children.count ?? 0) +
                (self.rootDirectory?.files.count ?? 0)
        }

        guard let item = item as? CoverageDirectory else {
            return 0
        }

        return item.children.count + item.files.count
    }

    func outlineView(_ outlineView: NSOutlineView,
                     viewFor tableColumn: NSTableColumn?,
                     item: Any) -> NSView? {

        if let item = item as? CoverageDirectory {
            if tableColumn!.identifier.rawValue == "filename" {
                let textView = outlineView.makeView(withIdentifier: tableColumn!.identifier,
                                                    owner: nil) as? FilenameCellView
                textView?.filename = item.name
                return textView
            } else if tableColumn!.identifier.rawValue == "coverage_percentage" {
                let textView = outlineView.makeView(withIdentifier: tableColumn!.identifier,
                owner: nil) as? NSTableCellView
                textView?.textField?.stringValue = "\(Int(item.coverage.coverage * 100))%"
                return textView
            } else if tableColumn?.identifier.rawValue == "coverage" {
                let covView = outlineView.makeView(withIdentifier: tableColumn!.identifier,
                                                   owner: nil) as? CoverageCellView
                covView?.coverage = item.coverage.coverage
                return covView
            }
        } else if let item = item as? CoverageFile {
            if tableColumn!.identifier.rawValue == "filename" {
                let textView = outlineView.makeView(withIdentifier: tableColumn!.identifier,
                                                    owner: nil) as? FilenameCellView
                textView?.filename = item.name
                return textView
            } else if tableColumn!.identifier.rawValue == "coverage_percentage" {
                let textView = outlineView.makeView(withIdentifier: tableColumn!.identifier,
                owner: nil) as? NSTableCellView
                textView?.textField?.stringValue = "\(Int(item.coverage.coverage * 100))%"
                return textView
            } else if tableColumn?.identifier.rawValue == "coverage" {
                let covView = outlineView.makeView(withIdentifier: tableColumn!.identifier,
                                                   owner: nil) as? CoverageCellView
                covView?.coverage = item.coverage.coverage
                return covView
            }
        }

        return nil
    }

    func outlineView(_ outlineView: NSOutlineView,
                     heightOfRowByItem item: Any) -> CGFloat {
        return 20
    }

}

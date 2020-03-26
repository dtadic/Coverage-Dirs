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

    func makeSorted(directory: CoverageDirectory) -> CoverageDirectory {
        guard let sort = self.outlineView.sortDescriptors.first else {
            return directory
        }

        var dir = directory

        if sort.key == "coverage" {
            dir.files.sort(by: {
                if sort.ascending {
                    return $0.coverage.coverage < $1.coverage.coverage
                }
                return $0.coverage.coverage > $1.coverage.coverage
            })

            dir.children.sort(by: {
                if sort.ascending {
                    return $0.coverage.coverage < $1.coverage.coverage
                }
                return $0.coverage.coverage > $1.coverage.coverage
            })
        } else {
            dir.files.sort(by: {
                if sort.ascending {
                    return $0.name < $1.name
                }
                return $0.name > $1.name
            })
            dir.children.sort(by: {
                if sort.ascending {
                    return $0.name < $1.name
                }
                return $0.name > $1.name
            })
        }

        for (index, child) in dir.children.enumerated() {
            dir.children[index] = makeSorted(directory: child)
        }

        return dir
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
        if let root = self.rootDirectory {
            var expanded = [UUID]()

            root.recurse { dir -> Void in
                if self.outlineView.isItemExpanded(dir) {
                    expanded.append(dir.id)
                }
            }

            self.rootDirectory = makeSorted(directory: root)

            var expandedCount = 0
            self.rootDirectory?.recurse { dir -> Bool in
                if expanded.contains(dir.id) {
                    self.outlineView.expandItem(dir)
                    expandedCount += 1
                }
                if expandedCount >= expanded.count {
                    return false
                }
                return true
            }
        }
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
                let textView = FilenameCellView()
                textView.filename = item.name
                return textView
            } else if tableColumn!.identifier.rawValue == "coverage_percentage" {
                return makeCoveragePercentageView(coverage: item.coverage)
            } else if tableColumn?.identifier.rawValue == "coverage" {
                return makeCoverageView(coverage: item.coverage)
            }
        } else if let item = item as? CoverageFile {
            if tableColumn!.identifier.rawValue == "filename" {
                let textView = FilenameCellView()
                textView.filename = item.name
                return textView
            } else if tableColumn!.identifier.rawValue == "coverage_percentage" {
                return makeCoveragePercentageView(coverage: item.coverage)
            } else if tableColumn?.identifier.rawValue == "coverage" {
                return makeCoverageView(coverage: item.coverage)
            }
        }

        return nil
    }

    func outlineView(_ outlineView: NSOutlineView,
                     heightOfRowByItem item: Any) -> CGFloat {
        return 20
    }

    private func makeCoveragePercentageView(coverage: CoverageData) -> NSView {
        let textView = NSTextField()

        textView.drawsBackground = false
        textView.isBezeled = false
        textView.isEditable = false

        textView.alignment = .right

        textView.stringValue = "\(Int(coverage.coverage * 100))%"
        return textView
    }

    private func makeCoverageView(coverage: CoverageData) -> NSView {
        let view = PercentageView(percentage: coverage.coverage)
        let hostingView = NSHostingView(rootView: view)

        let holderView = NSView()
        holderView.addSubview(hostingView)

        hostingView.translatesAutoresizingMaskIntoConstraints = false

        hostingView
            .heightAnchor
            .constraint(equalToConstant: 5)
            .isActive = true

        hostingView
            .leadingAnchor
            .constraint(equalTo: holderView.leadingAnchor)
            .isActive = true

        hostingView
            .trailingAnchor
            .constraint(equalTo: holderView.trailingAnchor)
            .isActive = true

        hostingView
            .centerYAnchor
            .constraint(equalTo: holderView.centerYAnchor)
            .isActive = true

        return holderView
    }

}

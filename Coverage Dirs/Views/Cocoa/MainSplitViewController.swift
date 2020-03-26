//
//  MainSplitViewController.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 24.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Cocoa
import os

class MainSplitViewController: NSSplitViewController {

    private weak var sidebarVC: SidebarViewController? {
        didSet {
            self.sidebarVC?.targets = self.targets
        }
    }
    private weak var coverageVC: CoverageViewController?

    var targets: [CoverageTarget] = [] {
        didSet {
            self.sidebarVC?.targets = self.targets
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let sidebarVC = self.children.first as? SidebarViewController {
            self.sidebarVC = sidebarVC
            sidebarVC.delegate = self
        }

        if let coverageVC = self.children.last as? CoverageViewController {
            self.coverageVC = coverageVC
        }

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showInputJS),
                                               name: .inputJSONSelected,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showOpenFile),
                                               name: .openDocument,
                                               object: nil)
    }

    override func viewDidAppear() {
        super.viewDidAppear()

        self.showOpenFile()
    }

    func clearData() {
        self.targets = []
        self.coverageVC?.rootDirectory = nil
        self.coverageVC?.outlineView.reloadData()
    }

    @objc private func showInputJS() {
        let pasteVC = StoryboardScene.Views.jsonPaste.instantiate()

        pasteVC.delegate = self

        self.presentAsSheet(pasteVC)
    }

    @objc private func showOpenFile() {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedFileTypes = ["xcresult"]
        guard let window = self.view.window else {
            return
        }

        openPanel.beginSheetModal(for: window) { (response) in
            if response == .OK {
                guard let path = openPanel.url?.path else {
                    return
                }
                self.coverageVC?.showLoading()
                self.clearData()

                DispatchQueue.global(qos: .userInitiated).async {
                    self.readfrom(path: path)
                    DispatchQueue.main.async {
                        self.coverageVC?.hideLoading()
                    }
                }
            }
        }
    }

    private func readfrom(path: String) {
        do {
            let task = Process()
            task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
            task.arguments = [
                "xcrun",
                "xccov",
                "view",
                "--report",
                "--json",
                path
            ]
            let outputPipe = Pipe()
            let errorPipe = Pipe()

            task.standardOutput = outputPipe
            task.standardError = errorPipe

            try task.run()

            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()

            let output = String(decoding: outputData, as: UTF8.self)
            let error = String(decoding: errorData, as: UTF8.self)

            os_log(.error, "Error from xccov: %@", error)

            do {
                try self.parseJson(output)
            } catch let error {
                NSLog("ERROR: %@", String(describing: error))
                DispatchQueue.main.async {
                    self.presentError(error)
                }
            }
        } catch let error {
            DispatchQueue.main.async {
                self.presentError(error)
            }
        }
    }

    private func parseJson(_ jsonString: String) throws {
        DispatchQueue.main.sync {
            self.clearData()
        }

        let data = try XCCovParser.parse(jsonString: jsonString)

        DispatchQueue.main.async {
            self.targets = data
        }
    }
}

extension MainSplitViewController: SidebarViewControllerDelegate {
    func sidebarDidSelect(target: CoverageTarget) {
        self.coverageVC?.rootDirectory = target.rootDirectory
        self.coverageVC?.outlineView.reloadData()
    }
}

extension MainSplitViewController: JsonPasteViewControllerDelegate {
    func jsonPasted(_ json: String) {
        do {
            try self.parseJson(json)
        } catch let error {
            NSLog("ERROR: %@", String(describing: error))
            DispatchQueue.main.async {
                self.presentError(error)
            }
        }
    }
}

extension MainSplitViewController: DragViewDelegate {
    func dragViewDidReceive(fileURLs: [URL]) {
        guard let path = fileURLs.first?.path else {
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.readfrom(path: path)
        }
    }

}

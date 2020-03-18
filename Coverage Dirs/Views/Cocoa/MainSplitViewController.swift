//
//  MainSplitViewController.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 24.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Cocoa

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
                let path = openPanel.url?.path

                do {
                    dump(FileManager.default.isReadableFile(atPath: path!))
                    try print(FileManager.default.contentsOfDirectory(atPath: path!))
                    let task = Process()
                    task.executableURL = URL(fileURLWithPath: "/usr/bin/env")
                    task.arguments = [
                        "xcrun",
                        "xccov",
                        "view",
                        "--report",
                        "--json",
                        path!
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

                    self.jsonPasted(output)
                } catch let error {
                    self.presentError(error)
                }
            }
        }
    }

    private func parseJson(_ jsonString: String) throws {
        let data = try XCCovParser.parse(jsonString: jsonString)

        self.targets = data
    }
}

extension MainSplitViewController: SidebarViewControllerDelegate {
    func sidebarDidSelect(target: CoverageTarget) {
        self.coverageVC?.rootDirectory = target.rootDirectory
    }
}

extension MainSplitViewController: JsonPasteViewControllerDelegate {
    func jsonPasted(_ json: String) {
        do {
            try self.parseJson(json)
        } catch let error {
            NSLog("ERROR: %@", String(describing: error))
            self.presentError(error)
        }
    }
}

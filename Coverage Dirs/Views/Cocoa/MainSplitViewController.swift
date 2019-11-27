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

        let jsonURL = Bundle.main.url(forResource: "test", withExtension: "json")!
        let jsonData = (try? Data(contentsOf: jsonURL))!
        let jsonString = String(data: jsonData, encoding: .utf8)
        let data = try? XCCovParser.parse(jsonString: jsonString!)

        self.targets = data ?? []

        if let sidebarVC = self.children.first as? SidebarViewController {
            self.sidebarVC = sidebarVC
            sidebarVC.delegate = self
        }

        if let coverageVC = self.children.last as? CoverageViewController {
            self.coverageVC = coverageVC
        }
    }

}

extension MainSplitViewController: SidebarViewControllerDelegate {
    func sidebarDidSelect(target: CoverageTarget) {
        self.coverageVC?.rootDirectory = target.rootDirectory
    }
}

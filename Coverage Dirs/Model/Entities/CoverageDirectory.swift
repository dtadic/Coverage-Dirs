//
//  CoverageDirectory.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Foundation

struct CoverageDirectory: Equatable, Hashable {
    let id = UUID()
    var name: String
    var files: [CoverageFile]
    var children: [CoverageDirectory]
    var coverage: CoverageData

    func recurse(_ action: (CoverageDirectory) -> Void ) {
        action(self)
        self.children.forEach({$0.recurse(action)})
    }

    @discardableResult
    func recurse(_ action: (CoverageDirectory) -> Bool) -> Bool {
        if !action(self) {
            return false
        }
        for child in children {
            if !child.recurse(action) {
                return false
            }
        }
        return true
    }
}

//
//  CoverageDirectory.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Foundation

class CoverageDirectory {
    var name: String
    var files: [CoverageFile]
    var children: [CoverageDirectory]
    var coverage: CoverageData

    init(name: String,
         files: [CoverageFile],
         children: [CoverageDirectory],
         coverage: CoverageData) {

        self.name = name
        self.files = files
        self.children = children
        self.coverage = coverage
    }

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
            child.recurse(action)
        }
        return true
    }

    func sort(by key: String, ascending: Bool) {
        if key == "coverage" {
            self.files.sort(by: {
                if ascending {
                    return $0.coverage.coverage < $1.coverage.coverage
                }
                return $0.coverage.coverage > $1.coverage.coverage
            })

            self.children.sort(by: {
                if ascending {
                    return $0.coverage.coverage < $1.coverage.coverage
                }
                return $0.coverage.coverage > $1.coverage.coverage
            })
        } else {
            self.files.sort(by: {
                if ascending {
                    return $0.name < $1.name
                }
                return $0.name > $1.name
            })
            self.children.sort(by: {
                if ascending {
                    return $0.name < $1.name
                }
                return $0.name > $1.name
            })
        }

        for child in self.children {
            child.sort(by: key, ascending: ascending)
        }
    }
}

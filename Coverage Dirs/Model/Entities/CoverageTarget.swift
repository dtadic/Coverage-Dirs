//
//  CoverageTarget.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Foundation

class CoverageTarget {
    var rootDirectory: CoverageDirectory
    var name: String

    init(rootDirectory: CoverageDirectory, name: String) {
        self.rootDirectory = rootDirectory
        self.name = name
    }
}

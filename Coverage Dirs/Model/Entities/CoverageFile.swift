//
//  CoverageFile.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Foundation

class CoverageFile {
    var name: String
    var coverage: CoverageData

    init(name: String, coverage: CoverageData) {
        self.name = name
        self.coverage = coverage
    }
}

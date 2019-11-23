//
//  CoverageDirectory.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Foundation

struct CoverageDirectory: Equatable, Hashable {
    var name: String
    var files: [CoverageFile]
    var children: [CoverageDirectory]
    var coverage: CoverageData
}

//
//  CoverageFile.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Foundation

struct CoverageFile: Equatable, Hashable {
    var name: String
    var coverage: CoverageData
}

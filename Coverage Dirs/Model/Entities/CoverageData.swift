//
//  CoverageData.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Foundation

struct CoverageData {
    var executableLines: Int
    var coveredLines: Int
    var coverage: Double {
        return Double(coveredLines) / Double(executableLines)
    }
}

//
//  CoverageData.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Foundation

struct CoverageData: Equatable, Hashable {
    var executableLines: Int
    var coveredLines: Int
    var coverage: Double {
        if executableLines == 0 {
            return 0
        }
        return Double(coveredLines) / Double(executableLines)
    }
}

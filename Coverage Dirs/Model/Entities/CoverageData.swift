//
//  CoverageData.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Foundation

struct CoverageData: Equatable, Hashable {
    var executableLines: Int {
        didSet {
            calculateCoverage()
        }
    }
    var coveredLines: Int {
        didSet {
            calculateCoverage()
        }
    }
    var coverage: Double = 0

    init(executableLines: Int, coveredLines: Int) {
        self.executableLines = executableLines
        self.coveredLines = coveredLines
        self.calculateCoverage()
    }

    private mutating func calculateCoverage() {
        if executableLines == 0 {
            coverage = 0
        }
        coverage =  Double(coveredLines) / Double(executableLines)
    }
}

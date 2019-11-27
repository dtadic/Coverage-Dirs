//
//  CoverageTargetView.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 23.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import SwiftUI

struct CoverageTargetView: View {
    var coverageTarget: CoverageTarget

    var body: some View {
        SidebarItemView(text: coverageTarget.name,
                        image: Image("archive"))
    }
}

struct CoverageTargetView_Previews: PreviewProvider {
    static var previews: some View {
        let coverageData = CoverageData(executableLines: 100, coveredLines: 90)
        let rootDir = CoverageDirectory(name: "test",
                                        files: [],
                                        children: [],
                                        coverage: coverageData)
        let target = CoverageTarget(rootDirectory: rootDir, name: "test")
        return CoverageTargetView(coverageTarget: target)
    }
}

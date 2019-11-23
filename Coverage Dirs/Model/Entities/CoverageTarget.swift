//
//  CoverageTarget.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Foundation

struct CoverageTarget: Identifiable, Equatable, Hashable {
    var id: String {
        return name
    }

    var rootDirectory: CoverageDirectory
    var name: String
}

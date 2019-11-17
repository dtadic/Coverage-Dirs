//
//  XCCovParser.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import Foundation

class XCCovParser {
    private init() {}

    public static func parse(jsonString: String) throws -> [CoverageTarget] {
        var targets = [CoverageTarget]()

        guard let jsonData = jsonString.data(using: .utf8) else {
            // TODO: Handle error
            return []
        }

        let decoder = JSONDecoder()
        let output = try decoder.decode(XCCovOutput.self,
                                        from: jsonData)

        for target in output.targets {
            targets.append(self.parseTarget(target))
        }

        return targets
    }

    private static func parseTarget(_ target: XCCovTarget) -> CoverageTarget {
        var coverageTarget = CoverageTarget(rootDirectory: buildTree(from: target.files),
                                            name: target.name)

        return coverageTarget
    }

    private static func buildTree(from files: [XCCovFile]) -> CoverageDirectory {
        var root = CoverageDirectory(name: "",
                                     files: [],
                                     children: [],
                                     coverage: CoverageData(executableLines: 0,
                                                            coveredLines: 0))

        for file in files {
            guard let filename = file.name.split(separator: "/").last else {
                assertionFailure("Can't find filename")
                continue
            }

            let coverageData = CoverageData(executableLines: file.executableLines,
                                            coveredLines: file.coveredLines)
            let coverageFile = CoverageFile(name: String(filename),
                                            coverage: coverageData)

            attach(coverageFile, path: file.path, to: &root)
        }

        return root
    }

    private static func attach(_ file: CoverageFile,
                               path: String,
                               to trunk: inout CoverageDirectory) {
        let parts = path.split(separator: "/", maxSplits: 1)

        assert(parts.count >= 1, "There should be at least 1 part")

        trunk.coverage.coveredLines += file.coverage.coveredLines
        trunk.coverage.executableLines += file.coverage.executableLines

        if parts.count == 1 {
            trunk.files.append(file)
        } else {
            let node = String(parts.first!)
            let others = String(parts.last!)
            if !trunk.children.contains(where: {$0.name == node}) {
                trunk.children.append(CoverageDirectory(name: node,
                                                        files: [],
                                                        children: [],
                                                        coverage: file.coverage))
            }
            let index = trunk.children.firstIndex(where: {$0.name == node})!
            attach(file, path: others, to: &trunk.children[index])
        }


    }

}

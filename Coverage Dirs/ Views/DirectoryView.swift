//
//  DirectoryView.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 23.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import SwiftUI

struct DirectoryView: View {
    var directory: CoverageDirectory
    @State var isExpanded = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image("play")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 7)
                    .rotationEffect(Angle(degrees: isExpanded ? 90 : 0))
                Text(directory.name)
                Spacer()
                PercentageView(percentage: directory.coverage.coverage)
                .frame(width: 150,
                       height: 7)
            }
                .onTapGesture {
                    self.isExpanded.toggle()
            }
            if isExpanded && !directory.children.isEmpty {
                ForEach(directory.children, id: \.name) { dir in
                    DirectoryView(directory: dir)
                }
                .padding(.leading, 20)
            }
            if isExpanded && !directory.files.isEmpty {
                ForEach(directory.files, id: \.name) { file in
                    HStack(alignment: .center) {
                        Text(file.name)
                        Spacer()
                        PercentageView(percentage: file.coverage.coverage)
                        .frame(width: 150,
                               height: 7)
                    }
                }
                .padding(.leading, 20)
            }
        }
    }
}

struct DirectoryView_Previews: PreviewProvider {
    static var previews: some View {
        let dir1 = CoverageDirectory(name: "child",
        files: [],
        children: [],
        coverage: CoverageData(executableLines: 10,
                               coveredLines: 5))
        let dir = CoverageDirectory(name: "asfd",
                                    files: [],
                                    children: [dir1, dir1],
                                    coverage: CoverageData(executableLines: 10,
                                                           coveredLines: 5))
        return DirectoryView(directory: dir)
    }
}

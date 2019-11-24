//
//  ContentView.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import SwiftUI
import Cocoa

struct MainView: View {
    @State var targets: [CoverageTarget] = []
    @State var selectedTarget: CoverageTarget?

    var body: some View {
        HSplitView {
            List(targets) { target in
                SidebarItemView(text: target.name,
                                image: Image("archive"))
                    .background(self.selectedTarget == target ?
                        Color(.controlHighlightColor) :
                        Color(.clear))
                    .onTapGesture {
                        if self.selectedTarget != target {
                            self.selectedTarget = target
                        }
                }

            }
            .padding(-20)
            .padding(.bottom, 20)
            .listStyle(SidebarListStyle())
            .background(VisualEffectView())
            .frame(minWidth: 100,
                   idealWidth: 150,
                   maxWidth: 300,
                   maxHeight: .infinity)

            if self.selectedTarget != nil {
                List {
                    DirectoryView(directory: self.selectedTarget!.rootDirectory)
                        .frame(minWidth: 200,
                               maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                }
            } else {
                Text("No target selected")
                    .font(.largeTitle)
                    .frame(minWidth: 200, maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(minWidth: 500, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
    }

    func setTargets(_ newValue: [CoverageTarget]) {
        self.targets = newValue
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//
//  ContentView.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 17.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HSplitView {
            List(1..<4) { number in
                Text(String(number))
            }
            .listStyle(SidebarListStyle())
            .frame(minWidth: 60, idealWidth: 150, maxWidth: 200)

            Text("aaaa")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

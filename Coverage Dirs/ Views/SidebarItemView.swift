//
//  SidebarItemView.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 19.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import SwiftUI

struct SidebarItemView: View {
    var text: String
    var image: Image

    var body: some View {
        ZStack() {
            HStack(alignment: .bottom) {
                image
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.primary)
                    .frame(height: 16)
                Text(text)
                    .lineLimit(1)
                Spacer()
            }
        }
        .padding(.horizontal, 12)
        .frame(height: 40)
    }
}

struct CoverageDirectoryView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarItemView(text: "errors", image: Image("alert_circle"))
        .frame(width: 300)
    }
}

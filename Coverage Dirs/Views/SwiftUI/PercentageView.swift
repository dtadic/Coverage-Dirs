//
//  PercentageView.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 23.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import SwiftUI

struct PercentageView: View {
    @Binding var percentage: Double

    var body: some View {
        GeometryReader { metrics in
            ZStack(alignment: .leading) {
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.95),
                                                           Color.green.opacity(0.6)]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .foregroundColor(.accentColor)
                    .frame(width: min(metrics.size.width * CGFloat(self.percentage), metrics.size.width))

                Capsule()
                    .strokeBorder(style: .init(lineWidth: 1, lineCap: .round, lineJoin: .miter))
                    .foregroundColor(.primary)
                    .opacity(0.4)
                    .blendMode(.normal)
            }.clipShape(Capsule())
        }
    }
}

struct PercentageView_Previews: PreviewProvider {
    static var previews: some View {
        PercentageView(percentage: .constant(0.11))
            .previewLayout(.fixed(width: 300, height: 15))

    }
}

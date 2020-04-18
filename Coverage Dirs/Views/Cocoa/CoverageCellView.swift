//
//  CoverageCellView.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 19.04.20.
//  Copyright © 2020 Dušan Tadić. All rights reserved.
//

import Cocoa
import SwiftUI

class CoverageCellView: NSTableCellView {

    var coverage: Double = 0
    private var percentageView: PercentageView!

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.percentageView =
            PercentageView(percentage: .init(get: { () -> Double in
                return self.coverage
            }, set: { new in
                self.coverage = new
            }))
        let hostingView = NSHostingView(rootView: self.percentageView)

        self.addSubview(hostingView)

        hostingView.translatesAutoresizingMaskIntoConstraints = false

        hostingView
            .heightAnchor
            .constraint(equalToConstant: 5)
            .isActive = true

        hostingView
            .leadingAnchor
            .constraint(equalTo: self.leadingAnchor)
            .isActive = true

        hostingView
            .trailingAnchor
            .constraint(equalTo: self.trailingAnchor)
            .isActive = true

        hostingView
            .centerYAnchor
            .constraint(equalTo: self.centerYAnchor)
            .isActive = true
    }

}

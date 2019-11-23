//
//  VisualEffectView.swift
//  Coverage Dirs
//
//  Created by Dušan Tadić on 19.11.19.
//  Copyright © 2019 Dušan Tadić. All rights reserved.
//

import SwiftUI

struct VisualEffectView: NSViewRepresentable {
    func updateNSView(_ nsView: NSVisualEffectView, context: NSViewRepresentableContext<VisualEffectView>) {

    }

    typealias NSViewType = NSVisualEffectView

    func makeNSView(context: NSViewRepresentableContext<VisualEffectView>) -> NSVisualEffectView {
        return NSVisualEffectView()
    }

}

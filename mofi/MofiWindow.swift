//
// Created by 山本一樹 on 2018/01/29.
// Copyright (c) 2018 Kazuki Yamamoto. All rights reserved.
//

import Foundation
import Cocoa
import Carbon.HIToolbox

class MofiWindow: NSPanel {
    private var config: Config!

    static func makeFrom(config: inout Config) -> MofiWindow {
        let p = MofiWindow()
        p.config = config
        let f = NSScreen.main?.visibleFrame
        p.level = .floating
        p.styleMask = [.unifiedTitleAndToolbar]
        p.setContentSize(NSSize(width: (f?.width ?? 0) * 0.8, height: 200))
        p.backgroundColor = .clear
        p.alphaValue = 1
        p.isOpaque = false
        p.center()

        return p
    }

    override var canBecomeKey: Bool {
        return true
    }

    override func keyDown(with event: NSEvent) {
        if event.keyCode == kVK_Escape {
            NSApp.terminate(self)
        }

        super.keyDown(with: event)
    }

    override func performClose(_ sender: Any?) {
        NSApp.terminate(self)
        super.performClose(sender)
    }
}

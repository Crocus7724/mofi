//
// Created by 山本一樹 on 2018/01/28.
// Copyright (c) 2018 Kazuki Yamamoto. All rights reserved.
//

import Foundation
import Cocoa


class SearchTextField: NSTextField {
    private var config: Config!

    init(config: inout Config) {
        super.init(frame: NSRect.zero)
        self.config = config
        self.focusRingType = .none
        self.font = NSFont.messageFont(ofSize: 38)
        self.isBordered = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var fontHeight: CGFloat {
        get {
            guard let font = self.font else {
                return 0
            }
            return NSLayoutManager().defaultLineHeight(for: font) + 1
        }
    }

    override func cancelOperation(_ sender: Any?) {
        NSApp.terminate(self)
    }
}


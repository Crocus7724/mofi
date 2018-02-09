//
// Created by 山本一樹 on 2018/01/28.
// Copyright (c) 2018 Kazuki Yamamoto. All rights reserved.
//

import Foundation
import Cocoa


class SearchTextField: NSTextField {
    private var config: Config!

    var fontHeight: CGFloat {
        get {
            guard let font = self.font else {
                return 0
            }
            return NSLayoutManager().defaultLineHeight(for: font) + 1
        }
    }

//    convenience init() {
//        self.init(string: "")
////            let m = NSLayoutManager()
////            let h = m.defaultLineHeight(for: font) + 1
////            let t = SearchTextField(frame: NSRect(
////                    x: 0,
////                    y: containerView.frame.height - h,
////                    width: window.contentView?.frame.size.width ?? 0,
////                    height: h
////            ))
//    }

    override func cancelOperation(_ sender: Any?) {
        NSApp.terminate(self)
    }

    static func makeFrom(config: inout Config) -> SearchTextField {
        let t = SearchTextField()
        t.config = config
        t.focusRingType = .none
        t.font = NSFont.messageFont(ofSize: 38)
        t.isBordered = false

        return t
    }
}


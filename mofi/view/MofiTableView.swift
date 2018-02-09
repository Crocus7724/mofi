//
// Created by 山本一樹 on 2018/01/29.
// Copyright (c) 2018 Kazuki Yamamoto. All rights reserved.
//

import Foundation
import Cocoa

class MofiTableView: NSTableView {
    static func makeFrom(config: inout Config) -> NSScrollView {
        let tableView = MofiTableView()
        let controllers = NSArrayController(content: ["hoge", "foo"])
        tableView.bind(NSBindingName.content, to: controllers, withKeyPath: "arrangedObjects")
        let c = NSTableColumn()
        tableView.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        c.resizingMask = .autoresizingMask
        tableView.addTableColumn(c)
        tableView.rowHeight = 30

        tableView.delegate = tableView
        tableView.dataSource = tableView

        tableView.backgroundColor = NSColor.blue
        let scrollView = NSScrollView()
        let clipView = NSClipView(frame: scrollView.frame)
        clipView.documentView = tableView
        scrollView.documentView = clipView

        return scrollView
    }
}

extension MofiTableView: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let t = NSTextField(string: "foo")
        t.frame = NSRect(x: 0, y: 0, width: tableColumn?.width ?? 0, height: tableView.rowHeight)
        t.focusRingType = .none
        t.isBordered = false
        t.backgroundColor = NSColor.clear
        return t
    }
}

extension MofiTableView: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 2
    }
}

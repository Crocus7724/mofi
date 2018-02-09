import Foundation
import Cocoa

fileprivate let tableViewRowHeight: CGFloat = 30

class MofiTableView: NSTableView {
    private var config: Config!

    init(config: inout Config) {
        super.init(frame: NSRect.zero)

        let controllers = NSArrayController(content: ["hoge", "foo"])
        self.bind(NSBindingName.content, to: controllers, withKeyPath: #keyPath(NSArrayController.arrangedObjects))
        let column = NSTableColumn()
        column.resizingMask = .autoresizingMask
        self.addTableColumn(column)
        self.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        self.rowHeight = tableViewRowHeight

        self.delegate = self
        self.dataSource = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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

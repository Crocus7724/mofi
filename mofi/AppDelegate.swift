//
//  AppDelegate.swift
//  mofi
//
//  Created by 山本一樹 on 2018/01/26.
//  Copyright © 2018 Kazuki Yamamoto. All rights reserved.
//

import Cocoa
import Carbon.HIToolbox
import QuartzCore


class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSPanel!
    var containerView: NSView!
    var textField: NSTextField!
    var tableView: NSTableView!
    @objc let foo = ["foo", "hoge"]

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        NSApp.activate(ignoringOtherApps: true)
        window = {
            let w = Panel()
            let f = NSScreen.main?.visibleFrame
            w.level = .floating
            w.styleMask = [.unifiedTitleAndToolbar]
            w.setContentSize(NSSize(width: (f?.width ?? 0) * 0.8, height: 200))
            w.backgroundColor = NSColor.clear
            w.alphaValue = 0.8
            w.isOpaque = false
            w.center()
            return w
        }()

        containerView = NSView(frame: window.frame)

        window.contentView = containerView

        textField = {
            let font = NSFont.messageFont(ofSize: 38)
            let m = NSLayoutManager()
            let h = m.defaultLineHeight(for: font) + 1
            let t = SearchTextField(frame: NSRect(
                    x: 0,
                    y: containerView.frame.height - h,
                    width: window.contentView?.frame.size.width ?? 0,
                    height: h
            ))
            t.isBordered = false
            t.focusRingType = .none
            t.font = font
            t.backgroundColor = NSColor.darkGray

//            let borderLayer = CALayer()
//            borderLayer.borderColor = NSColor.orange.cgColor
//            borderLayer.borderWidth = 3
//            borderLayer.frame = NSRect(x:t.frame.origin.x, y:t.frame.origin.y, width: 1, height: 1)
//            t.layer = borderLayer

            return t
        }()
//        let x = BorderView(frame: NSRect(x: 0, y: 0, width: textField.frame.width, height: 10))

//        containerView.addSubview(x)
        makeTableView()

        let v = containerView.frame.size.height - textField.frame.size.height
        let scrollView = NSScrollView(frame: NSRect(
                x: containerView.frame.origin.x,
                y: 0,
                width: containerView.frame.size.width,
                height: v - 3
        ))
        let clipView = NSClipView(frame: scrollView.frame)
        clipView.documentView = tableView
        scrollView.documentView = clipView
        containerView.addSubview(scrollView)

        containerView.addSubview(textField)
        containerView.addSubview(BorderView(frame: NSRect(
                x: 0,
                y: textField.frame.origin.y - 3,
                width: textField.frame.width,
                height: 3
        )))
        window.makeKeyAndOrderFront(self)
    }

    @objc func closeWindow() {
        NSApp.terminate(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationDidResignActive(_ notification: Notification) {
//        NSApp.terminate(self)
    }

    private func makeTableView() {
        tableView = NSTableView(frame: NSRect(
                x: containerView.frame.origin.x,
                y: 0,
                width: containerView.frame.size.width,
                height: containerView.frame.size.height - textField.frame.size.height
        ))
        let controllers = NSArrayController(content: foo)
        tableView.bind(NSBindingName.content, to: controllers, withKeyPath: "arrangedObjects")
        let c = NSTableColumn()
        tableView.columnAutoresizingStyle = .uniformColumnAutoresizingStyle
        c.resizingMask = .autoresizingMask
        tableView.addTableColumn(c)
        tableView.rowHeight = 30


        tableView.delegate = self
        tableView.dataSource = self

//        tableView.headerView = NSTableHeaderView(frame: NSRect(x: 0, y: 0, width: tableView.frame.width, height: 3))
        tableView.backgroundColor = NSColor.blue
    }
}

extension AppDelegate: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let t = NSTextField(string: "foo")
        t.frame = NSRect(x: 0, y: 0, width: tableColumn?.width ?? 0, height: tableView.rowHeight)
//        t.backgroundColor = NSColor.green
        t.focusRingType = .none
        t.isBordered = false
        t.backgroundColor = NSColor.clear
        return t
    }
}

extension AppDelegate: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 2
    }

//    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
//        return "foo"
//    }
}

class BorderView: NSView {
    convenience init() {
        self.init()
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.darkGray.setFill()
        dirtyRect.fill()

        // dash customization parameters
        let dashHeight: CGFloat = 10
        let dashLength: CGFloat = 5
        let dashColor: NSColor = .orange

        // setup the context
        let currentContext = NSGraphicsContext.current!.cgContext
        currentContext.setLineWidth(dashHeight)
        currentContext.setLineDash(phase: 0, lengths: [dashLength])
        currentContext.setStrokeColor(dashColor.cgColor)


        // draw the dashed path
        currentContext.addRect(NSRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width, height: 10))
        currentContext.strokePath()
    }
}

class Panel: NSPanel {
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
        print("ofoo")
        NSApp.terminate(self)
        super.performClose(sender)
    }
}

class TextField: NSTextField {
    override func keyDown(with event: NSEvent) {
        if event.keyCode == kVK_Escape {
            NSApp.terminate(self)
        }
        super.keyDown(with: event)
    }

    override func cancelOperation(_ sender: Any?) {
        NSApp.terminate(sender)
    }
}

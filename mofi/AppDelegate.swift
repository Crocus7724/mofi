//
//  AppDelegate.swift
//  mofi
//
//  Created by 山本一樹 on 2018/01/26.
//  Copyright © 2018 Kazuki Yamamoto. All rights reserved.
//

import Cocoa

let borderViewHeight: CGFloat = 3.0


class AppDelegate: NSObject, NSApplicationDelegate {
    var window: MofiWindow!
    var containerView: NSView!
    var textField: SearchTextField!
    var tableView: MofiTableView!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        NSApp.activate(ignoringOtherApps: true)
        var config = Config()
        window = MofiWindow.makeFrom(config: &config)

        containerView = NSView(frame: window.frame)

        window.contentView = containerView

        textField = SearchTextField.makeFrom(config: &config)
        textField.frame = NSRect(
                x: 0,
                y: containerView.frame.height - textField.fontHeight,
                width: containerView.frame.width,
                height: textField.fontHeight
        )

        let scrollViewHeight = containerView.frame.size.height - textField.frame.size.height
        let scrollView = MofiTableView.makeFrom(config: &config)
        scrollView.frame = NSRect(
                x: containerView.frame.origin.x,
                y: 0,
                width: containerView.frame.size.width,
                height: scrollViewHeight - borderViewHeight
        )
        containerView.addSubview(scrollView)
        containerView.addSubview(textField)
        let borderView = BorderView(config: &config)
        borderView.frame = NSRect(
                x: 0,
                y: textField.frame.origin.y - 3,
                width: textField.frame.width,
                height: borderViewHeight
        )
        containerView.addSubview(borderView)

        window.makeKeyAndOrderFront(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationDidResignActive(_ notification: Notification) {
        NSApp.terminate(self)
    }
}

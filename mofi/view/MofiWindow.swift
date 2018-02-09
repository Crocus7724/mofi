import Foundation
import Cocoa
import Carbon.HIToolbox

class MofiWindow: NSPanel {
    private var config: Config!

    init(config: inout Config) {
        super.init(contentRect: NSRect.zero, styleMask: [.unifiedTitleAndToolbar], backing: .buffered, defer: false)
        self.config = config
        let visibleFrame = NSScreen.main?.visibleFrame
        self.setContentSize(NSSize(width: (visibleFrame?.width ?? 0) * 0.8, height: 200))
        self.level = .floating
        self.styleMask = .unifiedTitleAndToolbar
        self.backgroundColor = .clear
        self.alphaValue = 0.8
        self.isOpaque = false
        self.center()
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

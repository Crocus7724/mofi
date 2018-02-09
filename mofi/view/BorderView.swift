import Foundation
import Cocoa

class BorderView: NSView {
    var config: Config!

    init(config: inout Config) {
        super.init(frame: NSRect.zero)
        self.config = config
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        NSColor.white.setFill()
        dirtyRect.fill()

        // dash customization parameters
        let dashHeight: CGFloat = 10
        let dashLength: CGFloat = 5
        let dashColor: NSColor = .clear

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

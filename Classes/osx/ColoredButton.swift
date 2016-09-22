//
//  ColoredButton.swift
//  KFAboutWindowPreview
//
//  Created by Gunnar Herzog on 22/09/2016.
//  Copyright © 2016 KF Interactive. All rights reserved.
//

import AppKit

@available(OSX 10.10, *)
public class ColoredButton: NSButton {
    public var color: NSColor = .black {
        didSet {
            redraw()
        }
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        redraw()
    }

    public override var title: String {
        didSet {
            redraw()
        }
    }

    private func redraw() {
        wantsLayer = true
        layerContentsRedrawPolicy = .onSetNeedsDisplay
        layer?.cornerRadius = 10
        layer?.borderWidth = 1.0
        layer?.borderColor = color.cgColor

        let paragraphStyle = NSParagraphStyle.default().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = .center
        attributedTitle = NSAttributedString(string: title, attributes: [NSFontAttributeName: font!, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: color])
    }

    override public var wantsUpdateLayer:Bool{
        return true
    }

    override public func updateLayer() {
        if isHighlighted {
            layer?.backgroundColor = color.lighter.cgColor
        } else {
            layer?.backgroundColor = nil
        }
        super.updateLayer()
    }

    override public var intrinsicContentSize: NSSize {
        let width = attributedTitle.size().width

        var size = super.intrinsicContentSize
        size.width = width + 3.0 * (layer?.cornerRadius ?? 0)
        return size
    }
}

extension NSColor {
    var lighter: NSColor {
        return NSColor(calibratedRed: redComponent, green: greenComponent, blue: blueComponent, alpha: 0.15)
    }
}

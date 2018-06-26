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
    @objc public var color: NSColor = .textColor {
        didSet {
            redraw()
        }
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        wantsLayer = true
        layerContentsRedrawPolicy = .onSetNeedsDisplay
        layer?.cornerRadius = 10
        layer?.borderWidth = 1.0
        
        redraw()
    }

    public override var title: String {
        didSet {
            redraw()
        }
    }

    private func redraw() {
        guard let font = font else { return }
        
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = .center
        attributedTitle = NSAttributedString(string: title, attributes: [.font: font, .paragraphStyle: paragraphStyle, .foregroundColor: color])
    }

    override public var wantsUpdateLayer:Bool {
        return true
    }

    override public func updateLayer() {
        if isHighlighted {
            layer?.backgroundColor = color.lighter.cgColor
        } else {
            layer?.backgroundColor = nil
        }
        layer?.borderColor = color.cgColor
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
        return withAlphaComponent(0.15)
    }
}

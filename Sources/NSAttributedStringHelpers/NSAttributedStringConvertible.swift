import SwiftUI

public protocol NSAttributedStringConvertible {

    var asAttributedString: NSMutableAttributedString { get }
}

extension String: NSAttributedStringConvertible {

    public var asAttributedString: NSMutableAttributedString {
        NSMutableAttributedString(string: self)
    }
}

extension NSAttributedString: NSAttributedStringConvertible {

    public var asAttributedString: NSMutableAttributedString {
        (self as? NSMutableAttributedString) ?? NSMutableAttributedString(attributedString: self)
    }
}

extension NSAttributedStringConvertible {

    public func font(_ font: UIFont) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.font, value: font)
    }

    public func paragraphStyle(_ style: NSParagraphStyle) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.paragraphStyle, value: style)
    }

    public func foregroundColor(_ color: UIColor) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.foregroundColor, value: color)
    }

    public func backgroundColor(_ color: UIColor) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.backgroundColor, value: color)
    }

    /// Integer, default 1: default ligatures, 0: no ligatures
    public func ligature(_ ligature: Int = 1) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.ligature, value: ligature as NSNumber)
    }

    /// Floating point value, in points; amount to modify default kerning. 0 means kerning is disabled.
    public func kern(_ kern: Float) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.kern, value: kern as NSNumber)
    }

    /// Floating point value, in points; amount to modify default tracking. 0 means tracking is disabled.
    @available(iOS 14.0, *)
    public func tracking(_ tracking: Float) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.tracking, value: tracking as NSNumber)
    }

    /// Integer, default 0: no strikethrough
    public func strikethrough(_ style: NSUnderlineStyle = .single, _ other: NSUnderlineStyle...) -> NSMutableAttributedString {
        asAttributedString.withAttribute(
            .strikethroughStyle,
            value: (other.reduce(style) { $0.union($1) }).rawValue as NSNumber
        )
    }

    public func underline(_ style: NSUnderlineStyle = .single, _ other: NSUnderlineStyle...) -> NSMutableAttributedString {
        asAttributedString.withAttribute(
            .underlineStyle,
            value: (other.reduce(style) { $0.union($1) }).rawValue as NSNumber
        )
    }

    /// Integer, default 0: no strikethrough
    public func strikethrough(_ style: NSUnderlineStyle = .single, _ other: NSUnderlineStyle..., color: UIColor) -> NSMutableAttributedString {
        strikethrough(
            other.reduce(style) { $0.union($1) }
        )
        .strikethroughColor(color)
    }
    
    public func underline(_ style: NSUnderlineStyle = .single, _ other: NSUnderlineStyle..., color: UIColor) -> NSMutableAttributedString {
        underline(
            other.reduce(style) { $0.union($1) }
        )
        .underlineColor(color)
    }
    
    /// UIColor, default nil: same as foreground color
    public func stroke(color: UIColor) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.strokeColor, value: color)
    }

    /// Floating point value, in percent of font point size, default 0: no stroke; positive for stroke alone, negative for stroke and fill (a typical value for outlined text would be 3.0)
    public func stroke(width: Float) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.strokeWidth, value: width as NSNumber)
    }

    public func stroke(color: UIColor, width: Float) -> NSMutableAttributedString {
        stroke(color: color).stroke(width: width)
    }
    
    public func shadow(offset: CGSize = .zero, blurRadius: CGFloat = 0, color: UIColor = .black) -> NSMutableAttributedString {
        let shadow = NSShadow()
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = blurRadius
        shadow.shadowColor = color
        return asAttributedString.withAttribute(.shadow, value: shadow)
    }

    public func textEffect(_ effect: NSAttributedString.TextEffectStyle) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.textEffect, value: effect.rawValue as NSString)
    }

    public func attachment(_ attachment: NSTextAttachment) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.attachment, value: attachment)
    }

    public func link(_ url: URL) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.link, value: url as NSURL)
    }

    /// Floating point value, in points; offset from baseline, default 0
    public func baselineOffset(_ offset: Float) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.baselineOffset, value: offset as NSNumber)
    }

    public func underlineColor(_ color: UIColor) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.underlineColor, value: color)
    }

    public func strikethroughColor(_ color: UIColor) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.strikethroughColor, value: color)
    }

    /// Floating point value; skew to be applied to glyphs, default 0: no skew
    public func obliqueness(_ obliqueness: Float) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.obliqueness, value: obliqueness as NSNumber)
    }

    /// NSNumber containing floating point value; log of expansion factor to be applied to glyphs, default 0: no expansion
    public func expansion(_ expansion: Float) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.expansion, value: expansion as NSNumber)
    }

    public func writingDirection(_ direction: NSWritingDirection, type: NSWritingDirectionFormatType) -> NSMutableAttributedString {
        if let value = NSAttributedString.writingDirectionValue(direction, type: type) {
            return asAttributedString.withAttribute(.writingDirection, value: value)
        }
        return asAttributedString
    }

    public func verticalGlyphForm(_ axis: NSLayoutConstraint.Axis = .vertical) -> NSMutableAttributedString {
        asAttributedString.withAttribute(.verticalGlyphForm, value: axis.rawValue as NSNumber)
    }

    public func lineSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.lineSpacing, value: spacing)
    }

    public func paragraphSpacing(_ spacing: CGFloat) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.paragraphSpacing, value: spacing)
    }

    public func alignment(_ alignment: NSTextAlignment) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.alignment, value: alignment)
    }

    public func firstLineHeadIndent(_ indent: CGFloat) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.firstLineHeadIndent, value: indent)
    }

    public func headIndent(_ indent: CGFloat) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.headIndent, value: indent)
    }

    public func tailIndent(_ indent: CGFloat) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.tailIndent, value: indent)
    }

    public func lineBreakMode(_ mode: NSLineBreakMode) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.lineBreakMode, value: mode)
    }

    public func minimumLineHeight(_ height: CGFloat) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.minimumLineHeight, value: height)
    }

    public func maximumLineHeight(_ height: CGFloat) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.maximumLineHeight, value: height)
    }

    public func baseWritingDirection(_ direction: NSWritingDirection) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.baseWritingDirection, value: direction)
    }

    public func lineHeightMultiple(_ multiple: CGFloat) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.lineHeightMultiple, value: multiple)
    }

    public func paragraphSpacingBefore( spacing: CGFloat) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.paragraphSpacingBefore, value: spacing)
    }

    public func hyphenationFactor(_ factor: Float) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.hyphenationFactor, value: factor)
    }

    @available(iOS 15.0, *)
    public func usesDefaultHyphenation( uses: Bool) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.usesDefaultHyphenation, value: uses)
    }

    public func tabStops(_ value: [NSTextTab]) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.tabStops, value: value)
    }

    public func defaultTabInterval(_ value: CGFloat) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.defaultTabInterval, value: value)
    }

    public func allowsDefaultTighteningForTruncation(_ value: Bool) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.allowsDefaultTighteningForTruncation, value: value)
    }

    public func lineBreakStrategy(_ value: NSParagraphStyle.LineBreakStrategy) -> NSMutableAttributedString {
        asAttributedString.withAttribute(\.lineBreakStrategy, value: value)
    }
}

extension NSMutableAttributedString {

    @discardableResult
    public func withAttribute(_ name: NSAttributedString.Key, value: Any) -> NSMutableAttributedString {
        addAttributes([name: value], range: NSRange(location: 0, length: length))
        return self
    }

    @discardableResult
    public func withAttribute<T>(_ keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, T>, value: T) -> NSMutableAttributedString {
        let style = attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
        style[keyPath: keyPath] = value
        return withAttribute(.paragraphStyle, value: style)
    }
}

extension NSAttributedString {
    
    static func writingDirectionValue(_ direction: NSWritingDirection, type: NSWritingDirectionFormatType) -> Any? {
        [direction.rawValue | type.rawValue as NSNumber] as NSArray
    }
}

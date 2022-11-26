import UIKit

extension NSAttributedString {
    
    public enum Attribute {
        
        /// font
        case font(UIFont)
        /// NSParagraphStyle, default defaultParagraphStyle
        case paragraphStyle(NSParagraphStyle = .default)
        /// UIColor, default blackColor/
        case foregroundColor(UIColor = .label)
        /// UIColor, default nil: no background
        case backgroundColor(UIColor)
        /// NSNumber containing integer, default 1: default ligatures, 0: no ligatures
        case ligature(Int = 1)
        /// NSNumber containing floating point value, in points; amount to modify default kerning. 0 means kerning is disabled.
        case kern(Float)
        /// NSNumber containing floating point value, in points; amount to modify default tracking. 0 means tracking is disabled.
        /// available from iOS 14.0
        case tracking(Float)
        /// NSNumber containing integer, default 0: no strikethrough
        case strikethrough(NSUnderlineStyle)
        /// NSNumber containing integer, default 0: no underline
        case underline(NSUnderlineStyle)
        /// UIColor, default nil: same as foreground color
        case strokeColor(UIColor)
        /// NSNumber containing floating point value, in percent of font point size, default 0: no stroke; positive for stroke alone, negative for stroke and fill (a typical value for outlined text would be 3.0
        case strokeWidth(Float = 0)
        /// NSShadow, default nil: no shadow
        case shadow(NSShadow)
        /// NSString, default nil: no text effect
        case textEffect(NSAttributedString.TextEffectStyle)
        /// NSTextAttachment
        case attachment(NSTextAttachment)
        /// NSURL (preferred) or NSString
        case link(URL)
        /// NSNumber containing floating point value, in points; offset from baseline, default 0
        case baselineOffset(Float = 0)
        /// UIColor, default nil: same as foreground color
        case underlineColor(UIColor)
        /// UIColor, default nil: same as foreground color
        case strikethroughColor(UIColor)
        /// NSNumber containing floating point value; skew to be applied to glyphs, default 0: no skew/
        case obliqueness(Float = 0)
        /// NSNumber containing floating point value; log of expansion factor to be applied to glyphs, default 0: no expansion
        case expansion(Float = 0)
        /// NSArray of NSNumbers representing the nested levels of writing direction overrides as defined by Unicode LRE, RLE, LRO, and RLO characters.
        /// The control characters can be obtained by masking NSWritingDirection and NSWritingDirectionFormatType values.
        /// LRE: NSWritingDirectionLeftToRight|NSWritingDirectionEmbedding,
        /// RLE: NSWritingDirectionRightToLeft|NSWritingDirectionEmbedding,
        /// LRO: NSWritingDirectionLeftToRight|NSWritingDirectionOverride,
        /// RLO: NSWritingDirectionRightToLeft|NSWritingDirectionOverride
        case writingDirection(NSWritingDirection, NSWritingDirectionFormatType)
        /// An NSNumber containing an integer value.  0 means horizontal text.  1 indicates vertical text.
        /// If not specified, it could follow higher-level vertical orientation settings.
        /// Currently on iOS, it's always horizontal.  The behavior for any other value is undefined.
        case verticalGlyphForm(NSLayoutConstraint.Axis = .vertical)
    }
}

public extension NSMutableAttributedString {
    
    var range: NSRange {
        NSRange(location: 0, length: length)
    }
    
    func addAttributes(_ attributes: [Attribute], range: NSRange? = nil) {
        attributes.forEach {
            self.addAttribute($0, range: range ?? self.range)
        }
    }
    
    func addAttributes(_ attributes: Attribute..., range: NSRange? = nil) {
        addAttributes(attributes, range: range)
    }
}

private extension NSMutableAttributedString {
    
    func addAttribute(_ attribute: Attribute, range: NSRange?) {
        let range = range ?? self.range
        switch attribute {
        case let .font(font):
            addAttribute(.font, value: font, range: range)
        case let .paragraphStyle(style):
            addAttribute(.paragraphStyle, value: style, range: range)
        case let .foregroundColor(color):
            addAttribute(.foregroundColor, value: color, range: range)
        case let .backgroundColor(color):
            addAttribute(.backgroundColor, value: color, range: range)
        case let .ligature(ligature):
            addAttribute(.ligature, value: ligature as NSNumber, range: range)
        case let .kern(kern):
            addAttribute(.kern, value: kern as NSNumber, range: range)
        case let .tracking(tracking):
            if #available(iOS 14.0, *) {
                addAttribute(.tracking, value: tracking as NSNumber, range: range)
            }
        case let .strikethrough(style):
            addAttribute(.strikethroughStyle, value: style.rawValue as NSNumber, range: range)
        case let .underline(style):
            addAttribute(.underlineStyle, value: style.rawValue as NSNumber, range: range)
        case let .strokeColor(color):
            addAttribute(.strokeColor, value: color, range: range)
        case let .strokeWidth(width):
            addAttribute(.strokeWidth, value: width, range: range)
        case let .shadow(shadow):
            addAttribute(.shadow, value: shadow, range: range)
        case let .textEffect(effect):
            addAttribute(.textEffect, value: effect.rawValue as NSString, range: range)
        case let .attachment(attachment):
            addAttribute(.attachment, value: attachment, range: range)
        case let .link(url):
            addAttribute(.link, value: url as NSURL, range: range)
        case let .baselineOffset(offset):
            addAttribute(.baselineOffset, value: offset as NSNumber, range: range)
        case let .underlineColor(color):
            addAttribute(.underlineColor, value: color, range: range)
        case let .strikethroughColor(color):
            addAttribute(.strikethroughColor, value: color, range: range)
        case let .obliqueness(obliqueness):
            addAttribute(.obliqueness, value: obliqueness as NSNumber, range: range)
        case let .expansion(expansion):
            addAttribute(.expansion, value: expansion as NSNumber, range: range)
        case let .writingDirection(direction, type):
            if let value = NSAttributedString.writingDirectionValue(direction, type: type) {
                addAttribute(.writingDirection, value: value, range: range)
            }
        case let .verticalGlyphForm(axis):
            switch axis {
            case .vertical:
                addAttribute(.verticalGlyphForm, value: 1 as NSNumber, range: range)
            case .horizontal:
                addAttribute(.verticalGlyphForm, value: 0 as NSNumber, range: range)
            @unknown default:
                break
            }
        }
    }
}

extension NSAttributedString.Attribute {

    public static func shadow(
        offset: CGSize = .zero,
        blurRadius: CGFloat = 0,
        color: UIColor = .black
    ) -> NSAttributedString.Attribute {
        let shadow = NSShadow()
        shadow.shadowOffset = offset
        shadow.shadowBlurRadius = blurRadius
        shadow.shadowColor = color
        return .shadow(shadow)
    }
    
    public static var ligature: NSAttributedString.Attribute { .ligature(1) }
    public static var noLigature: NSAttributedString.Attribute { .ligature(0) }
    public static var strikethroug: NSAttributedString.Attribute { .strikethrough(.single) }
    public static var noStrikethroug: NSAttributedString.Attribute { .strikethrough([]) }
    public static var underline: NSAttributedString.Attribute { .underline(.single) }
    public static var noUnderline: NSAttributedString.Attribute { .underline([]) }
    
    public static func underline(
        _ first: NSUnderlineStyle,
        _ second: NSUnderlineStyle,
        _ other: NSUnderlineStyle...
    ) -> NSAttributedString.Attribute  {
        .underline(
            other.reduce(first.union(second)) { $0.union($1) }
        )
    }
    
    public static func strikethrough(
        _ first: NSUnderlineStyle,
        _ second: NSUnderlineStyle,
        _ other: NSUnderlineStyle...
    ) -> NSAttributedString.Attribute  {
        .strikethrough(
            other.reduce(first.union(second)) { $0.union($1) }
        )
    }
    
    public static func attachment(image: UIImage) -> NSAttributedString.Attribute {
        .attachment(NSTextAttachment(image: image))
    }
}

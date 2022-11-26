import SwiftUI

extension ExpressibleByStringLiteral where Self: NSAttributedString {
    
    public init(stringLiteral: String) {
        self.init(string: stringLiteral)
    }
}

extension ExpressibleByStringInterpolation where Self: NSAttributedString {
    
    public init(stringInterpolation: StringInterpolation) {
        self.init(attributedString: stringInterpolation.attributedString)
    }
}

extension NSAttributedString: ExpressibleByStringInterpolation {
    
    public convenience init(_ stringInterpolation: StringInterpolation) {
        self.init(stringInterpolation: stringInterpolation)
    }
    
    public struct StringInterpolation: StringInterpolationProtocol {
        
        fileprivate let attributedString: NSMutableAttributedString
        
        public init(literalCapacity: Int, interpolationCount: Int) {
            self.attributedString = NSMutableAttributedString()
        }
        
        public mutating func appendLiteral(_ literal: String) {
            self.attributedString.append(NSAttributedString(string: literal))
        }
        
        public mutating func appendInterpolation(_ value: Any, _ attributes: Attribute...) {
            appendInterpolation("\(value)", attributes)
        }
        
        public mutating func appendInterpolation(_ value: some NSAttributedStringConvertible, _ attributes: Attribute...) {
            appendInterpolation(value, attributes)
        }
        
        public mutating func appendInterpolation(_ value: Any, _ color: UIColor) {
            appendInterpolation(value, .foregroundColor(color))
        }
        
        public mutating func appendInterpolation(_ value: Any, _ font: UIFont) {
            appendInterpolation(value, .font(font))
        }
        
        public mutating func appendInterpolation(_ value: UIImage) {
            appendInterpolation(NSAttributedString(attachment: NSTextAttachment(image: value)))
        }
        
        private mutating func appendInterpolation(_ value: some NSAttributedStringConvertible, _ attributes: [Attribute]) {
            let string = value.asAttributedString
            string.addAttributes(attributes)
            self.attributedString.append(string)
        }
    }
}

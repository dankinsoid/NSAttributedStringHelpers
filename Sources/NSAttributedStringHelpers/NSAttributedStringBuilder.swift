import Foundation

@resultBuilder
public enum NSAttributedStringBuilder {
    
    @inlinable
    public static func buildBlock(_ components: NSMutableAttributedString...) -> NSMutableAttributedString {
        buildArray(components)
    }
    
    @inlinable
    public static func buildOptional(_ component: NSMutableAttributedString?) -> NSMutableAttributedString {
        component ?? NSMutableAttributedString()
    }
    
    @inlinable
    public static func buildEither(first component: NSMutableAttributedString) -> NSMutableAttributedString {
        component
    }
    
    @inlinable
    public static func buildEither(second component: NSMutableAttributedString) -> NSMutableAttributedString {
        component
    }
    
    @inlinable
    public static func buildLimitedAvailability(_ component: NSMutableAttributedString) -> NSMutableAttributedString {
        component
    }
    
    @inlinable
    public static func buildArray(_ components: [NSMutableAttributedString]) -> NSMutableAttributedString {
        components.reduce(NSMutableAttributedString()) { partialResult, string in
            partialResult.append(string)
            return partialResult
        }
    }
    
    @inlinable
    public static func buildExpression(_ expression: some NSAttributedStringConvertible) -> NSMutableAttributedString {
        expression.asAttributedString
    }
}

public extension NSAttributedString {
    
    convenience init(@NSAttributedStringBuilder _ builder: () -> NSMutableAttributedString) {
        self.init(attributedString: builder())
    }
}

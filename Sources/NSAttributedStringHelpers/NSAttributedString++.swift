import Foundation

/// Concatenates two attributed strings.
///
/// - Parameters:
///   - lhs: The first attributed string.
///   - rhs: The second attributed string.
/// - Returns: The concatenated attributed string.
public func +(lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let newAttributedString = NSMutableAttributedString(attributedString: lhs)
    newAttributedString.append(rhs)
    return newAttributedString
}

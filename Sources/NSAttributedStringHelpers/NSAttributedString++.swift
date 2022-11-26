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

func eee() {
    
    NSAttributedString {
        "Some initial text"
            .font(.systemFont(ofSize: 12))
            .foregroundColor(.systemBlue)
        
        "Some link"
            .link(URL(string: "some.url")!)
            
        NSAttributedString {
            "Some grouped text"
            "With different attributes"
                .kern(0.3)
                .underline(.byWord, color: .systemBlue)
        }
        .font(.boldSystemFont(ofSize: 16))
    }
    
    let literalAttributed: NSAttributedString = """
Some \("attributed", .foregroundColor(.systemRed)) literal text
Some values \(12, .underline(.byWord), .ligature).
"""
}

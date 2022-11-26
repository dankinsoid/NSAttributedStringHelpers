# NSAttributedStringHelpers

[![CI Status](https://img.shields.io/travis/dankinsoid/NSAttributedStringHelpers.svg?style=flat)](https://travis-ci.org/dankinsoid/NSAttributedStringHelpers)
[![Version](https://img.shields.io/cocoapods/v/NSAttributedStringHelpers.svg?style=flat)](https://cocoapods.org/pods/NSAttributedStringHelpers)
[![License](https://img.shields.io/cocoapods/l/NSAttributedStringHelpers.svg?style=flat)](https://cocoapods.org/pods/NSAttributedStringHelpers)
[![Platform](https://img.shields.io/cocoapods/p/NSAttributedStringHelpers.svg?style=flat)](https://cocoapods.org/pods/NSAttributedStringHelpers)


## Description
This repository provides

## Example

```swift
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
```

 
## Installation

1. [Swift Package Manager](https://github.com/apple/swift-package-manager)

Create a `Package.swift` file.
```swift
// swift-tools-version:5.7
import PackageDescription

let package = Package(
  name: "SomeProject",
  dependencies: [
    .package(url: "https://github.com/dankinsoid/NSAttributedStringHelpers.git", from: "1.0.1")
  ],
  targets: [
    .target(name: "SomeProject", dependencies: ["NSAttributedStringHelpers"])
  ]
)
```
```ruby
$ swift build
```

2.  [CocoaPods](https://cocoapods.org)

Add the following line to your Podfile:
```ruby
pod 'NSAttributedStringHelpers'
```
and run `pod update` from the podfile directory first.

## Author

dankinsoid, voidilov@gmail.com

## License

NSAttributedStringHelpers is available under the MIT license. See the LICENSE file for more info.

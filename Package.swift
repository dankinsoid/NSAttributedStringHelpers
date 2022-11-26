// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NSAttributedStringHelpers",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13)
    ],
    products: [
        .library(name: "NSAttributedStringHelpers", targets: ["NSAttributedStringHelpers"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "NSAttributedStringHelpers",
            dependencies: [
            ]
        )
    ]
)

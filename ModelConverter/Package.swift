// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModelConverter",
    products: [
        .library(
            name: "ModelConverter",
            targets: ["ModelConverter"]),
    ],
    targets: [
        .target(
            name: "ModelConverter",
            dependencies: []),
        .testTarget(
            name: "ModelConverterTests",
            dependencies: ["ModelConverter"]),
    ]
)

// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ModelConverter",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "ModelConverter",
            targets: ["ModelConverter"]),
    ],
    dependencies: [
        .package(path: "../Models")
    ],
    targets: [
        .target(
            name: "ModelConverter",
            dependencies: ["Models"]),
        .testTarget(
            name: "ModelConverterTests",
            dependencies: ["ModelConverter"]),
    ]
)

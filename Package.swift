// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RSDevPanel",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "RSDevPanel",
            targets: ["RSDevPanel"])
    ],
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit", from: .init(5, 0, 0))
    ],
    targets: [
        .target(
            name: "RSDevPanel",
            dependencies: ["SnapKit"]),
        .testTarget(
            name: "RSDevPanelTests",
            dependencies: ["RSDevPanel"]),
    ]
)

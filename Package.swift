// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "CoreNetworking",
    platforms: [
        .iOS(.v15),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "CoreNetworking",
            targets: ["CoreNetworking"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CoreNetworking",
            dependencies: []
        ),
    ]
)

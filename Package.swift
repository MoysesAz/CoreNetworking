import PackageDescription

let package = Package(
    name: "NetworkingLayer",
    platforms: [
        .iOS(.v15),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "NetworkingLayer",
            targets: ["NetworkingLayer"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "NetworkingLayer",
            dependencies: []
        ),
    ]
)
